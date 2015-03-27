From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Mar 2015 20:43:34 +0900
Subject: [PATCH 0/4] kbuild: refactor Makefile inclusion
Message-ID: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada (4):
  kbuild: use relative path to include Makefile
  kbuild: use relative path more to include Makefile
  kbuild: include $(src)/Makefile rather than $(obj)/Makefile
  kbuild: ia64: use $(src)/Makefile.gate rather than particular path

 Makefile                  | 22 ++++++++++------------
 arch/arm/boot/Makefile    |  2 +-
 arch/ia64/kernel/Makefile |  2 +-
 arch/mips/Makefile        |  2 +-
 arch/um/Makefile          |  6 +++---
 arch/x86/Makefile         |  2 +-
 arch/x86/Makefile.um      |  2 +-
 scripts/Makefile.dtbinst  |  2 +-
 scripts/Makefile.fwinst   |  2 +-
 9 files changed, 20 insertions(+), 22 deletions(-)

-- 
1.9.1
