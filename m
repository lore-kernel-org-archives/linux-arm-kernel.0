From: lars.persson@axis.com (Lars Persson)
Date: Fri,  9 Oct 2015 17:33:32 +0200
Subject: [PATCH 0/1] arm: Add generic smc wrapper
Message-ID: <cover.1444404015.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is intended for new machines that call secure monitors compliant with ARM
DEN 0028A.

Changes since RFC:
* Build only for V6 and V7 CPUs.

Lars Persson (1):
  arm: Add generic smc wrapper

 arch/arm/include/asm/smc-call.h | 12 ++++++++++++
 arch/arm/kernel/Makefile        |  3 +++
 arch/arm/kernel/smc-call.S      | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm/include/asm/smc-call.h
 create mode 100644 arch/arm/kernel/smc-call.S

-- 
2.1.4
