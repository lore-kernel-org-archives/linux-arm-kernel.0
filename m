From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 22:53:27 +0900
Subject: [GIT PULL 4/4] dt-exynos 2 for v3.10
Message-ID: <51656ED7.90506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is one more pull-request for exynos dt update for v3.10.
Please pull.

Thanks.

- Kukjin
----------------------------------------------------------------

The following changes since commit 31d39248810072dec3279463d5fda0001721c01c:

   ARM: dts: add mshc controller node for Exynos4x12 SoCs (2013-04-10 
17:51:32 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/dt-exynos-2-for-v3.10

for you to fetch changes up to 9251646b7a36059f8667f87fa00361a776bf19a2:

   ARM: EXYNOS: Enable XHCI support on exynos5 (2013-04-10 19:38:41 +0900)

----------------------------------------------------------------
This updates device tree for keypad for smdk4412 and origen4412 boards 
and adds mfc clock entries for exynos4 and enables usb2phy and usb3phy 
and dwc3-exynos for exynos5250

----------------------------------------------------------------
Sachin Kamat (5):
       ARM: dts: Remove keypad entries from exynos4x12-pinctrl.dtsi
       ARM: dts: Add keypad entries to Exynos4412 based Origen
       ARM: dts: Add keypad entries to SMDK4412
       ARM: dts: Add MFC clock entries for exynos4
       ARM: dts: Update MFC documentation for clock entries

Vivek Gautam (5):
       ARM: dts: Enabling samsung-usb2phy driver for exynos5250
       ARM: dts: Enabling samsung-usb3phy driver for exynos5250
       ARM: dts: Add device tree bindings for dwc3-exynos
       ARM: dts: Enabling dwc3-exynos driver for exynos5250
       ARM: EXYNOS: Enable XHCI support on exynos5

  .../devicetree/bindings/media/s5p-mfc.txt          |  5 ++
  .../devicetree/bindings/usb/exynos-usb.txt         | 34 +++++++++
  arch/arm/boot/dts/exynos4.dtsi                     |  2 +
  arch/arm/boot/dts/exynos4412-origen.dts            | 62 +++++++++++++++
  arch/arm/boot/dts/exynos4412-smdk4412.dts          | 87 
++++++++++++++++++++++
  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          | 56 --------------
  arch/arm/boot/dts/exynos5250.dtsi                  | 45 +++++++++++
  arch/arm/mach-exynos/Kconfig                       |  1 +
  8 files changed, 236 insertions(+), 56 deletions(-)
