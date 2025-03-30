pipeline{
    agent any

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

        // build dan push docker image sesuai perintah build_push_image_karsajobs_ui.sh
        stage("build-app-karsajobs-ui"){
            steps {
                // mengambil credential Personal Access Token Github dari Jenkins dan Set ke environment os
                // mengambil password Docker Hub dari Jenkins dan Set ke environment os
                withCredentials([
                    string(credentialsId: 'GITHUB_PAT', variable: 'GITHUB_PAT'),
                    string(credentialsId: 'DOCKER_HUB_PW', variable: 'DOCKER_HUB_PW')
                    ]) {
                  sh '''
                  export CR_PAT=$GITHUB_PAT
                  export DOCKER_HUB_PW=$DOCKER_HUB_PW
                  chmod +x build_push_image_karsajobs_ui.sh
                  ./build_push_image_karsajobs_ui.sh
                  ''' 
                }
            }
        }
    }
    post{
        always{
            // logout akun docker pada kondisi apapun agar akun yang digunakan aman
            // menghapus semua credential dengan mengupdatenya menjadi null
            sh '''
            docker logout
            export CR_PAT=null
            export DOCKER_HUB_PW=null
            '''
            echo "========docker logout success========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}