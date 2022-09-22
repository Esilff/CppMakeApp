#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

$(./gl/checkGlDependency.sh -i)


if [[ $? -eq 0 ]]; then
    cd ../$1
    echo "find_package(glfw3 3.3 REQUIRED)
find_package(OpenGL REQUIRED)

target_link_librairies(\${PROJECT_NAME} glfw \${GLFW_LIBRAIRIES})
target_link_librairies(\${PROJECT_NAME} OpenGL::GL)" >> src/CMakeLists.txt
    printf "#include <GLFW/glfw3.h>

int main(void)
{
    GLFWwindow* window;

    /* Initialize the library */
    if (!glfwInit())
        return -1;

    /* Create a windowed mode window and its OpenGL context */
    window = glfwCreateWindow(640, 480, \"Hello World\", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        return -1;
    }

    /* Make the window's context current */
    glfwMakeContextCurrent(window);

    /* Loop until the user closes the window */
    while (!glfwWindowShouldClose(window))
    {
        /* Render here */
        glClear(GL_COLOR_BUFFER_BIT);

        /* Swap front and back buffers */
        glfwSwapBuffers(window);

        /* Poll for and process events */
        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}" > main.cpp
else 
    echo -e "${RED}[Error] : Some dependencies are missing, use <command> to check the missing ones.${NC}"
    exit 1
fi
exit 0