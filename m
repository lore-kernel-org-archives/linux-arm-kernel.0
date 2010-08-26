From: meenayakri@gmail.com (Meenakshi Yakri)
Date: Thu, 26 Aug 2010 11:20:14 +0530
Subject: need to profile the qt/cpp code with arm-linux-gprof
Message-ID: <AANLkTikZCK0nx29ctDX_vZmQe-jKciMi_wjNLsCO+RYu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
I need to profile my qt project/cpp code how to do this.
I am working on ARM-Linux I have GCC
tried profiling with arm-linux-gprof but not working.. the steps i followed
to do this are
1. added the following lines in .pro file of my qt project
CONFIG += DEBUG
QMAKE_CXXFLAGS_DEBUG += -pg
QMAKE_LFLAGS_DEBUG += -pg
did qmake,, make
& after running it din't generate gmon.out
so i am not able to profile..

any other steps to do this profiling using arm-linux-gprof please tell
or any other profiling tools, how to get them & how to use please help
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100826/dfce5e6c/attachment-0001.html>
