set(EXECUTABLE_FULL_PATH
    ${CMAKE_BINARY_DIR}/${EXECUTABLE}
)

configure_file(${CMAKE_CURRENT_LIST_DIR}/launch.json.in
${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
@ONLY
)
