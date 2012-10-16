From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 17:46:36 +0100
Subject: [PATCH 0/4] arm64: Random fixes for 3.7
Message-ID: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are a few AArch64 fixes I want to get in 3.7.

Comments welcome. Thanks.


Catalin Marinas (4):
  arm64: Select MODULES_USE_ELF_RELA
  arm64: Fix the update_vsyscall() prototype
  arm64: Ignore memory blocks below PHYS_OFFSET
  arm64: No need to set the x0-x2 registers in start_thread()

 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/processor.h | 10 ----------
 arch/arm64/kernel/setup.c          | 12 ++++++++++++
 arch/arm64/kernel/vdso.c           | 20 ++++++++++----------
 4 files changed, 23 insertions(+), 20 deletions(-)
