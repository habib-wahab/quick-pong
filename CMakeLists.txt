cmake_minimum_required(VERSION 3.16)

project(quick-pong VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appquick-pong
    src/cpp/main.cpp
    resources/resources.qrc
    src/cpp/player_touch_handler.h
    src/cpp/player_touch_handler.cpp
)

qt_add_qml_module(appquick-pong
    URI quick-pong
    VERSION 1.0
    QML_FILES src/qml/Main.qml src/qml/Player.qml src/qml/Ball.qml
)

set_target_properties(appquick-pong PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appquick-pong
    PRIVATE Qt6::Quick
)

install(TARGETS appquick-pong
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
