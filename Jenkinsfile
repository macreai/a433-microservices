pipeline{
    agent any
    
    // menggunakan go versi 1.15 sesuai karsajobs
    tools {
        go '1.15'
    }

    stages{
        // proses checkout source code
        stage("checkout"){
            steps{
                checkout scm
            }
        }

        // download hadolint dan melakukan hadolint terhadap Dockerfile
        stage("lint-dockerfile"){
            steps {
                sh 'curl -fsSL https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 -o hadolint'
                sh 'chmod +x hadolint'
                sh './hadolint Dockerfile'
            }
        }

        // menjalakan unit test pada project karsajobs backend
        stage("test-app"){
            steps {
                sh 'go test -v -short --count=1 $(go list ./...)'
            }
        }

        // build dan push docker image sesuai perintah build_push_image_karsajobs.sh
        stage("build-app-karsajobs"){
            steps {
                // mengambil credential Personal Access Token Github dari Jenkins dan Set ke environment os
                withCredentials([string(credentialsId: 'GITHUB_PAT', variable: 'GITHUB_PAT')]) {
                  sh '''
                  export CR_PAT=$GITHUB_PAT
                  ./build_push_image_karsajobs.sh
                  ''' 
                }
            }
        }
    }
    post{
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}