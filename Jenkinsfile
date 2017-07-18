#!/usr/bin/env groovy
@Library('pipelineLibraries')_

nodeDocker {
  stage('git: checkout') {
    checkout scm
  }

  stage('packer: gather files') {
    packerFiles = findFiles glob: 'templates/*.json'
    assert packerFiles : ''
  }

  stage('packer: build amis') {
    def dockerVersion = params.dockerVersion ?: '17.06'
    docker.image('reynn/docker-packer:latest').inside {
      withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
        credentialsId: 'reynn-aws-ec2'
      ]]) {
        for (packerFile in packerFiles) {
          println "Building $packerFile"
          sh """
            packer build \
              -var 'aws_access_key=${env.AWS_ACCESS_KEY_ID}' \
              -var 'aws_secret_key=${env.AWS_SECRET_ACCESS_KEY}' \
              -var 'docker_version=$dockerVersion' \
              $packerFile
            """
        }
      }
    }
  }
}
