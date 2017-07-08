#!/usr/bin/env groovy

@Library('pipelineLibraries')_

nodeDocker {
  stage('git: checkout') {
    checkout scm
  }

  stage('aws: build ami') {
    docker.image('reynn/docker-packer:latest').inside {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
        credentialsId: 'reynn-aws-ec2'
      ]]) {
        sh """
        |packer build \
        | -var 'aws_access_key=${env.AWS_ACCESS_KEY_ID}' \
        | -var 'aws_secret_key=${env.AWS_SECRET_ACCESS_KEY}' \
        | test.json
        """.stripMargin()
      }
    }
  }
}
