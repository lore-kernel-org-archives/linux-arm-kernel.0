From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:15 +0000
Subject: [PATCH 0/9] arm64: minor fixups and enhancements
Message-ID: <cover.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin and Will,

Here is a series of various fixups and improvements for arm64.  Please
consider.

-Geoff

The following changes since commit 94156675847c14a9b16e91b035da32e35e98ef79:

  Revert "arm64: dmi: Add SMBIOS/DMI support" (2014-07-31 14:00:03 +0100)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-arm64

for you to fetch changes up to 4192d403bb9703063c59a052293faa19d38d2f02:

  arm64: Add new cpu-return-addr device tree binding (2014-08-22 12:30:41 -0700)

----------------------------------------------------------------
Geoff Levand (9):
      arm64: Fix efi kernel entry
      arm64: Fix INVALID_HWID definition
      arm64: Remove unneeded extern keyword
      arm64: Remove unused variable in head.S
      arm64: Fix include header order in vmlinux.lds.S
      arm64: Add new routine local_disable
      arm64: Add atomic macros to assembler.h
      arm64: Add missing AT() macros to vmlinux.lds.S
      arm64: Add new cpu-return-addr device tree binding

 Documentation/devicetree/bindings/arm/cpus.txt | 25 +++++++++++++++++++
 arch/arm64/include/asm/assembler.h             | 33 ++++++++++++++++++++++++++
 arch/arm64/include/asm/cpu_ops.h               |  4 ++--
 arch/arm64/include/asm/cputype.h               |  2 +-
 arch/arm64/include/asm/irqflags.h              | 13 ++++++++++
 arch/arm64/kernel/head.S                       |  8 +++----
 arch/arm64/kernel/vmlinux.lds.S                | 14 +++++------
 7 files changed, 85 insertions(+), 14 deletions(-)

-- 
1.9.1
