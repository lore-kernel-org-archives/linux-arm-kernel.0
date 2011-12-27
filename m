From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 27 Dec 2011 18:48:05 +0900
Subject: [GIT PULL] Samsung devel-ohci for v3.3
Message-ID: <000901ccc47c$a1d0db70$e5729250$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the samsung-devel-ohci for v3.3.
The USB stuff got the ack from Greh and he agreed to send to upstream via
samsung tree.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 384703b8e6cd4c8ef08512e596024e028c91c339:

  Linux 3.2-rc6 (2011-12-16 18:36:26 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-devel-ohci

Jingoo Han (3):
      ARM: EXYNOS: Add USB OHCI device
      ARM: EXYNOS: Add USB OHCI support to SMDKV310 board
      USB: Add Samsung Exynos OHCI diver

Tushar Behera (1):
      ARM: EXYNOS: Add USB OHCI support to ORIGEN board

 arch/arm/mach-exynos/Kconfig              |    7 +
 arch/arm/mach-exynos/Makefile             |    1 +
 arch/arm/mach-exynos/dev-ohci.c           |   52 ++++++
 arch/arm/mach-exynos/include/mach/map.h   |    1 +
 arch/arm/mach-exynos/include/mach/ohci.h  |   21 +++
 arch/arm/mach-exynos/mach-origen.c        |   13 ++
 arch/arm/mach-exynos/mach-smdkv310.c      |   13 ++
 arch/arm/mach-exynos/setup-usb-phy.c      |   15 ++
 arch/arm/plat-samsung/include/plat/devs.h |    1 +
 drivers/usb/Kconfig                       |    1 +
 drivers/usb/host/Kconfig                  |    6 +
 drivers/usb/host/ohci-exynos.c            |  274
+++++++++++++++++++++++++++++
 drivers/usb/host/ohci-hcd.c               |    5 +
 13 files changed, 410 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-ohci.c
 create mode 100644 arch/arm/mach-exynos/include/mach/ohci.h
 create mode 100644 drivers/usb/host/ohci-exynos.c
