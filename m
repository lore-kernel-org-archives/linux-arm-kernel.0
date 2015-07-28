From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 28 Jul 2015 14:09:43 +0200
Subject: [PULL REQUEST] ARM: mediatek: soc updates for v4.3
Message-ID: <CABuKBeL8e1eZ3LNYWkKg38qJk+XZ-+Oy+112rLMvkMuwKtL-JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Please take the following patches.

Thanks,
Matthias

--

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.2-next-soc

for you to fetch changes up to 3e0452d27a784d50f09bec9de8ac673849b9e303:

  ARM: mediatek: Add regmap to mediatek Kconfig (2015-07-23 20:01:42 +0200)

----------------------------------------------------------------
- ARM: mediatek: Add regmap to mediatek Kconfig
- soc: mediatek: Drop owner assignment from platform_driver
- soc: Mediatek: Add SCPSYS power domain driver
- dt-bindings: soc: Add documentation for the MediaTek SCPSYS unit
- soc: mediatek: Add infracfg misc driver support

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      soc: mediatek: Drop owner assignment from platform_driver

Matthias Brugger (1):
      ARM: mediatek: Add regmap to mediatek Kconfig

Sascha Hauer (3):
      soc: mediatek: Add infracfg misc driver support
      dt-bindings: soc: Add documentation for the MediaTek SCPSYS unit
      soc: Mediatek: Add SCPSYS power domain driver

 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  41 ++
 arch/arm/mach-mediatek/Kconfig                     |   1 +
 drivers/soc/mediatek/Kconfig                       |  19 +
 drivers/soc/mediatek/Makefile                      |   2 +
 drivers/soc/mediatek/mtk-infracfg.c                |  91 ++++
 drivers/soc/mediatek/mtk-pmic-wrap.c               |   1 -
 drivers/soc/mediatek/mtk-scpsys.c                  | 487 +++++++++++++++++++++
 include/dt-bindings/power/mt8173-power.h           |  15 +
 include/linux/soc/mediatek/infracfg.h              |  26 ++
 9 files changed, 682 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
 create mode 100644 drivers/soc/mediatek/mtk-infracfg.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.c
 create mode 100644 include/dt-bindings/power/mt8173-power.h
 create mode 100644 include/linux/soc/mediatek/infracfg.h

-- 
motzblog.wordpress.com
