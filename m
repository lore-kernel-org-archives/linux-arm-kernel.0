From: yi.li@linaro.org (Yi Li)
Date: Sat,  7 Sep 2013 00:02:50 +0800
Subject: [PATCH] Add dmi driver support on arm
Message-ID: <1378483371-19858-1-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: liyi <yi.li@linaro.org>

x86 and IA64 have the DMI support, which is useful for supporting
SMBIOS specification. All these SMBIOS tables will give the hardware
information for user or applications.

This patch depends on EFI runtime service function which
not yet upstreamed, it has been generated against the tag
leg-20130906.0 on git://git.linaro.org/people/graemegregory/linux.git."

liyi (1):
  ARM:DMI: Add dmi driver support on arm

 arch/arm/Kconfig           |    9 +++++++++
 arch/arm/include/asm/dmi.h |   12 ++++++++++++
 arch/arm/kernel/setup.c    |    7 ++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/dmi.h

-- 
1.7.9.5
