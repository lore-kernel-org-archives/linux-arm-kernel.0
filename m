From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 19 Sep 2013 11:46:39 +0100
Subject: [GIT PULL] Removeal of 0x's from DT address spaces
Message-ID: <20130919104639.GD22389@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM-SoC,

This is the remainder of a patchset that's been on the MLs for quite a
while now. It's a simple set which removes the unecessary '0x's from
device node headers i.e. s/dev at 0xaaaaaaaa/dev at aaaaaaaa/. Most of the
patches have been taken in by individual maintainers and this is
what's left.

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git tb-0x-removeal

for you to fetch changes up to 5621ed85635680def9bbf75c107b20bb913f14bb:

  ARM: SPEAr3xx: DT: Remove '0x's from Spear 320 DTS file (2013-09-19 11:36:20 +0100)

----------------------------------------------------------------
Lee Jones (5):
      ARM: ux500: Remove '0x's from HREF v60+ DTS file
      ARM: at91: dt: Remove '0x's from Animeo IP DTS file
      ARM: SPEAr3xx: DT: Remove '0x's from Spear 300 DTS file
      ARM: SPEAr3xx: DT: Remove '0x's from Spear 310 DTS file
      ARM: SPEAr3xx: DT: Remove '0x's from Spear 320 DTS file

 arch/arm/boot/dts/animeo_ip.dts       | 2 +-
 arch/arm/boot/dts/spear300.dtsi       | 2 +-
 arch/arm/boot/dts/spear310.dtsi       | 2 +-
 arch/arm/boot/dts/spear320.dtsi       | 2 +-
 arch/arm/boot/dts/ste-hrefv60plus.dts | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

Kind regards,
Lee

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
