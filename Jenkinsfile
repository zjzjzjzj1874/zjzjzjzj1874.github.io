#!groovy
@Library('jenkinslib@main') _

def tools = new org.devops.tools()
def email = new org.devops.notify_email()
def wechat = new org.devops.notify_wechat()

// 部署脚本
def deploy() {
    sh '''
        sudo docker build -f Dockerfile -t docsify:${DOCKER_TAG} .
        sudo docker push docsify:${DOCKER_TAG}
        envsubst < docsify.yaml | kubectl apply -f -
    '''
}

pipeline {
  options {
    timestamps() // 显示日志时间戳 => 使用前先安装插件
    skipDefaultCheckout() // 隐式删checkout scm语句
    timeout(time: 20, unit: 'MINUTES') // 流水线超时设置:20min
  }
  agent none

  parameters {
    string (name: 'DOCKER_TAG', defaultValue: 'latest', description: 'docker镜像tag，默认latest')
  }
  environment { // 全局变量定义
    DOCKER_TAG = "${params.DOCKER_TAG}"
  }
  stages {

    stage('Check on Controller') {
      agent { label 'HOST' }

      stages {
        stage('Cleaning workspace') {
          steps { sh 'ls -l && sudo rm -rf ./*' }
        }

        stage('SCE Checkout') {
            steps { checkout scm }
        }

        stage('Stash artifacts') {
          steps {
            stash name: 'source', includes: '**', excludes: '**/.git,**/.git/**'
          }
        }

        stage('Tag Version Prepare') {
          steps {
            script {
                // 部署环境
                echo "当前版本:${DOCKER_TAG}"
                if (env.DOCKER_TAG == '' || env.DOCKER_TAG == 'latest') {
                    echo "替换默认的latest版本"
                    DOCKER_TAG=sh(script: "git log -n 1 --pretty=format:%H", returnStdout: true)
                }
                echo "替换后版本:${DOCKER_TAG}"
            }
          }
        }
      }
    }

    stage ('Deploy on Main') {
      environment {
        DOCKER_TAG = "${DOCKER_TAG}"
        NS = 'devops'
      }
      agent { label 'HOST' }
      stages {
          stage('Cleaning workspace') {
              steps {
                  sh 'ls -l'
                  sh 'sudo rm -rf ./*'
              }
          }

          stage('Unstash artifacts') {
            steps {
              unstash 'source'
            }
          }
          stage('Building && Starting') {
            steps {
              script {deploy ()}
            }
          }
      }
    }
  }

  // 构建后操作
  post {
    always { script { tools.PrintMsg("构建完成","green") }}
    success { script { currentBuild.description = "构建成功！" }}
    failure { script {
        currentBuild.description = "构建失败！"
        tools.PrintMsg("构建失败,发送邮件和企业微信推送","red")
        email.EmailNotify("本次构建失败")
        wechat.WorkWechatNotifyWithMsg("https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=your-key","构建失败")
    }}
    aborted { script { currentBuild.description = "取消本次构建！" }}
  }
}

