# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux

# Include any dependencies generated for this target.
include CMakeFiles/tictactoe.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/tictactoe.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/tictactoe.dir/flags.make

CMakeFiles/tictactoe.dir/main.cc.o: CMakeFiles/tictactoe.dir/flags.make
CMakeFiles/tictactoe.dir/main.cc.o: main.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/tictactoe.dir/main.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tictactoe.dir/main.cc.o -c /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/main.cc

CMakeFiles/tictactoe.dir/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tictactoe.dir/main.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/main.cc > CMakeFiles/tictactoe.dir/main.cc.i

CMakeFiles/tictactoe.dir/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tictactoe.dir/main.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/main.cc -o CMakeFiles/tictactoe.dir/main.cc.s

CMakeFiles/tictactoe.dir/my_application.cc.o: CMakeFiles/tictactoe.dir/flags.make
CMakeFiles/tictactoe.dir/my_application.cc.o: my_application.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/tictactoe.dir/my_application.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tictactoe.dir/my_application.cc.o -c /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/my_application.cc

CMakeFiles/tictactoe.dir/my_application.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tictactoe.dir/my_application.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/my_application.cc > CMakeFiles/tictactoe.dir/my_application.cc.i

CMakeFiles/tictactoe.dir/my_application.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tictactoe.dir/my_application.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/my_application.cc -o CMakeFiles/tictactoe.dir/my_application.cc.s

CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o: CMakeFiles/tictactoe.dir/flags.make
CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o: flutter/generated_plugin_registrant.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o -c /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/flutter/generated_plugin_registrant.cc

CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/flutter/generated_plugin_registrant.cc > CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.i

CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/flutter/generated_plugin_registrant.cc -o CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.s

# Object files for target tictactoe
tictactoe_OBJECTS = \
"CMakeFiles/tictactoe.dir/main.cc.o" \
"CMakeFiles/tictactoe.dir/my_application.cc.o" \
"CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o"

# External object files for target tictactoe
tictactoe_EXTERNAL_OBJECTS =

intermediates_do_not_run/tictactoe: CMakeFiles/tictactoe.dir/main.cc.o
intermediates_do_not_run/tictactoe: CMakeFiles/tictactoe.dir/my_application.cc.o
intermediates_do_not_run/tictactoe: CMakeFiles/tictactoe.dir/flutter/generated_plugin_registrant.cc.o
intermediates_do_not_run/tictactoe: CMakeFiles/tictactoe.dir/build.make
intermediates_do_not_run/tictactoe: flutter/ephemeral/libflutter_linux_gtk.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libgtk-3.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libgdk-3.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libpango-1.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libharfbuzz.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libatk-1.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libcairo-gobject.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libcairo.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libgio-2.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libgobject-2.0.so
intermediates_do_not_run/tictactoe: /usr/lib/x86_64-linux-gnu/libglib-2.0.so
intermediates_do_not_run/tictactoe: CMakeFiles/tictactoe.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable intermediates_do_not_run/tictactoe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tictactoe.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/tictactoe.dir/build: intermediates_do_not_run/tictactoe

.PHONY : CMakeFiles/tictactoe.dir/build

CMakeFiles/tictactoe.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/tictactoe.dir/cmake_clean.cmake
.PHONY : CMakeFiles/tictactoe.dir/clean

CMakeFiles/tictactoe.dir/depend:
	cd /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux /home/lukasz/Dokumenty/nauka/studia/jnp3/tic-tac-toe/linux/CMakeFiles/tictactoe.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/tictactoe.dir/depend

