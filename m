From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Aug 2014 15:37:13 +0800
Subject: [GIT PULL][for v3.17] pull request on fixing PXA DT
Message-ID: <CAN1soZz_j2=DzazzLC1FV+kDtyhHRb4CYY3=vm+OmwEhQ1SqWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd, Kevin,

Please help to merge the pull request from PXA git tree.

Best Regards
Haojian

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
tags/fix-pxa-dt-v3.17

for you to fetch changes up to 960a1042caf5e2f96fe9ddff98a4735aa9288080:

  ARM: pxa3xx: provide specific platform_devices for all ssp ports
(2014-08-25 15:10:54 +0800)

----------------------------------------------------------------
Fix DT bindings on PXA MMC/USB/SOUND

----------------------------------------------------------------
Daniel Mack (4):
      ARM: pxa: dts: fix mmc controller compatible string
      ARM: pxa: dts: fix ohci controller compatible string
      ARM: pxa: ssp: provide platform_device_id for PXA3xx
      ARM: pxa3xx: provide specific platform_devices for all ssp ports

 arch/arm/boot/dts/pxa2xx.dtsi |  4 ++--
 arch/arm/mach-pxa/devices.c   | 42 ++++++++++++++++++++++++++++++++++++++++--
 arch/arm/mach-pxa/devices.h   |  3 +++
 arch/arm/mach-pxa/pxa3xx.c    | 14 +++++++-------
 arch/arm/plat-pxa/ssp.c       |  1 +
 5 files changed, 53 insertions(+), 11 deletions(-)
