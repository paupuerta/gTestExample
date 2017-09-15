#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
message (" CMAKE_functions mocs ${CMAKE_CURRENT_SOURCE_DIR}/src")
#
#Funcion gen_moc
# Genera los ficheros .cxx
# Parametros:
#   SRC_MOC     variable destino con los ficheros .cxx
#   DEST_PATH   path de destino para los ficheros .cxx (opcional)
#               puede ser absoluto o relativo (si es relativo lo sera al path del .h)
#   HEADERS_MOC lista de ficheros .h a procesar
#
function(gen_moc SRC_MOC DEST_PATH HEADERS_MOC)
	if (NOT HEADERS_MOC AND NOT ARGN)
		message(SEND_ERROR "Error: gen_moc() called without any moc files")
		message("${ARGN}")
		return()
	endif(NOT HEADERS_MOC AND NOT ARGN)

   IF(EXISTS "${DEST_PATH}/")
      SET (HEADERS_MOC ${HEADERS_MOC} ${ARGN})
      FOREACH(it ${HEADERS_MOC})

         GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_cxx ${it} NAME_WE)

         SET (it_cxx ${DEST_PATH}/${it_cxx}.cxx)
         EXECUTE_PROCESS(COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx})

			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_cxx}
				COMMENT "gen_moc ${it_cxx}"
				DEPENDS ${it_abs}
				COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx}
			)

         SET (SRC_MOC_LOCAL ${SRC_MOC_LOCAL} ${it_cxx})
      ENDFOREACH(it)
      SET (${SRC_MOC} ${SRC_MOC_LOCAL} PARENT_SCOPE)
   ELSEIF(EXISTS "${DEST_PATH}")
      SET (HEADERS_MOC ${DEST_PATH} ${HEADERS_MOC} ${ARGN})
      FOREACH(it ${HEADERS_MOC})

         GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_cxx ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)

         SET (it_cxx ${it_path}/${it_cxx}.cxx)
         EXECUTE_PROCESS(COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx})
			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_cxx}
				COMMENT "gen_moc ${it_cxx}"
				DEPENDS ${it_abs}
				COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx}
			)
         SET (SRC_MOC_LOCAL ${SRC_MOC_LOCAL} ${it_cxx})
      ENDFOREACH(it)
      SET (${SRC_MOC} ${SRC_MOC_LOCAL} PARENT_SCOPE)
   ELSE()
      SET (HEADERS_MOC ${HEADERS_MOC} ${ARGN})
      FOREACH(it ${HEADERS_MOC})
         
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_cxx ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)
         SET (it_cxx ${it_path}/${DEST_PATH}/${it_cxx}.cxx)
         IF(EXISTS ${it_path}/${DEST_PATH})
            EXECUTE_PROCESS(COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx})
				ADD_CUSTOM_COMMAND (
					OUTPUT ${it_cxx}
					COMMENT "gen_moc ${it_cxx}"
					DEPENDS ${it_abs}
					COMMAND ${QT_MOC_EXECUTABLE} ${it_abs} -o ${it_cxx}
				)
         ELSE()
            message ("_path no exist Moc ${it_path}/${DEST_PATH}")
         ENDIF()
         SET (SRC_MOC_LOCAL ${SRC_MOC_LOCAL} ${it_cxx})
      ENDFOREACH(it)
      SET (${SRC_MOC} ${SRC_MOC_LOCAL} PARENT_SCOPE)
   ENDIF()
endfunction(gen_moc)



#QT4_WRAP_UI(helloworld_FORMS_HEADERS ${helloworld_FORMS})

#
#Funcion gen_ui
# Genera los ficheros .cxx
# Parametros:
#   SRC_UI       variable destino con los ficheros .cxx
#   DEST_PATH   path de destino para los ficheros .cxx (opcional)
#               puede ser absoluto o relativo (si es relativo lo sera al path del .h)
#   HEADERS_UI   lista de ficheros .h a procesar
#
function(gen_ui SRC_UI DEST_PATH HEADERS_UI)
   IF(EXISTS "${DEST_PATH}/")
      SET (HEADERS_UI ${HEADERS_UI} ${ARGN})
      FOREACH(it ${HEADERS_UI})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_ui ${it} NAME_WE)

         SET (it_ui ${DEST_PATH}/ui_${it_ui}.h)
         EXECUTE_PROCESS(COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui})

			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_ui}
				COMMENT "gen_ui ${it_ui}"
				DEPENDS ${it_abs}
				COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui}
			)

         SET (SRC_UI_LOCAL ${SRC_UI_LOCAL} ${it_ui})
      ENDFOREACH(it)
      SET (${SRC_UI} ${SRC_UI_LOCAL} PARENT_SCOPE)
   ELSEIF(EXISTS "${DEST_PATH}")
      SET (HEADERS_UI ${DEST_PATH} ${HEADERS_UI} ${ARGN})
      FOREACH(it ${HEADERS_UI})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_ui ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)
         SET (it_ui ${it_path}/ui_${it_ui}.h)
         EXECUTE_PROCESS(COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui})
			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_ui}
				COMMENT "gen_ui ${it_ui}"
				DEPENDS ${it_abs}
				COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui}
			)
         SET (SRC_UI_LOCAL ${SRC_UI_LOCAL} ${it_ui})
      ENDFOREACH(it)
      SET (${SRC_UI} ${SRC_UI_LOCAL} PARENT_SCOPE)
   ELSE()
      SET (HEADERS_UI ${HEADERS_UI} ${ARGN})
      FOREACH(it ${HEADERS_UI})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_ui ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)
         SET (it_ui ${it_path}/${DEST_PATH}/ui_${it_ui}.h)
         IF(EXISTS ${it_path}/${DEST_PATH})
            EXECUTE_PROCESS(COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui})
				ADD_CUSTOM_COMMAND (
					OUTPUT ${it_ui}
					COMMENT "gen_ui ${it_ui}"
					DEPENDS ${it_abs}
					COMMAND ${QT_UI_EXECUTABLE} ${it_abs} -o ${it_ui}
				)
         ELSE()
            message ("_path no exist UI ${it_path}/${DEST_PATH}")
         ENDIF()
         SET (SRC_UI_LOCAL ${SRC_UI_LOCAL} ${it_ui})
      ENDFOREACH(it)
      SET (${SRC_UI} ${SRC_UI_LOCAL} PARENT_SCOPE)
   ENDIF()
endfunction(gen_ui)

#
#Funcion gen_qrc
# Genera los ficheros qrc
# Parametros:
#   SRC_QRC     variable destino con los ficheros qrc_xxx.cpp
#   DEST_PATH   path de destino para los ficheros qrc_xxx.cpp (opcional)
#               puede ser absoluto o relativo (si es relativo lo sera al path del .qrc)
#   HEADERS_QRC  lista de ficheros qrc a procesar
#
function(gen_qrc SRC_QRC DEST_PATH HEADERS_QRC)
   IF(EXISTS "${DEST_PATH}/")
      SET (HEADERS_QRC ${HEADERS_QRC} ${ARGN})
      FOREACH(it ${HEADERS_QRC})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_qrc ${it} NAME_WE)
		
         SET (it_qrc ${DEST_PATH}/qrc_${it_qrc}.cpp)
         EXECUTE_PROCESS(COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc})

			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_qrc}
				COMMENT "gen_qrc ${it_qrc}"
				DEPENDS ${it_abs}
				COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc}
			)

         SET (SRC_QRC_LOCAL ${SRC_QRC_LOCAL} ${it_qrc})
      ENDFOREACH(it)
      SET (${SRC_QRC} ${SRC_QRC_LOCAL} PARENT_SCOPE)
   ELSEIF(EXISTS "${DEST_PATH}")
      SET (HEADERS_QRC ${DEST_PATH} ${HEADERS_QRC} ${ARGN})
      FOREACH(it ${HEADERS_QRC})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_qrc ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)
         SET (it_qrc ${it_path}/qrc_${it_ui}.cpp)
         EXECUTE_PROCESS(COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc})
			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_qrc}
				COMMENT "gen_qrc ${it_qrc}"
				DEPENDS ${it_abs}
				COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc}
			)
         SET (SRC_QRC_LOCAL ${SRC_QRC_LOCAL} ${it_qrc})
      ENDFOREACH(it)
      SET (${SRC_QRC} ${SRC_QRC_LOCAL} PARENT_SCOPE)
   ELSE()
      SET (HEADERS_QRC ${HEADERS_QRC} ${ARGN})
      FOREACH(it ${HEADERS_QRC})
			GET_FILENAME_COMPONENT(it_abs ${it} ABSOLUTE)
         GET_FILENAME_COMPONENT(it_qrc ${it} NAME_WE)
         GET_FILENAME_COMPONENT(it_path ${it} PATH)
         SET (it_qrc ${it_path}/${DEST_PATH}/qrc_${it_qrc}.cpp)
         IF(EXISTS ${it_path}/${DEST_PATH})
            EXECUTE_PROCESS(COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc})
			ADD_CUSTOM_COMMAND (
				OUTPUT ${it_qrc}
				COMMENT "gen_qrc ${it_qrc}"
				DEPENDS ${it_abs}
				COMMAND ${QT_QRC_EXECUTABLE} ${it_abs} -o ${it_qrc}
			)
         ELSE()
            message ("_path no exist QRC ${it_path}/${DEST_PATH}")
         ENDIF()
         SET (SRC_QRC_LOCAL ${SRC_QRC_LOCAL} ${it_qrc})
      ENDFOREACH(it)
      SET (${SRC_QRC} ${SRC_QRC_LOCAL} PARENT_SCOPE)
   ENDIF()
endfunction(gen_qrc)
