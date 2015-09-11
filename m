From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 11 Sep 2015 23:52:50 +0200
Subject: [PATCH v2 0/3] Add support for the Armada-370-based Seagate NAS
Message-ID: <1442008373-19184-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the Seagate machines based on the
Armada-370 Marvell SoC. This includes the Personal Cloud 1 and 2-Bay
and the Seagate NAS 2 and 4-Bay.

Changes for v2:
- Rename DTS files using the products names.
- Update model and compatible properties as well.
- Add some informations allowing to identify the devices in the commit
  message and in the DTS files headers.
- Remove duplicated rtc alias in armada-370-seagate-nas-xbay.dtsi.

Thanks,

Simon

Simon Guinot (2):
  ARM: mvebu: add DT support for Seagate Personal Cloud
  ARM: mvebu: enable options for Seagate NAS in mvebu_v7_defconfig

Vincent Donnefort (1):
  ARM: mvebu: add DT support for Seagate NAS 2 and 4-Bay

 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts  |  36 ++++
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 133 ++++++++++++
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 231 +++++++++++++++++++++
 .../armada-370-seagate-personnal-cloud-2bay.dts    |  51 +++++
 .../dts/armada-370-seagate-personnal-cloud.dts     |  37 ++++
 .../dts/armada-370-seagate-personnal-cloud.dtsi    | 174 ++++++++++++++++
 arch/arm/configs/mvebu_v7_defconfig                |   9 +-
 8 files changed, 674 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud-2bay.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud.dts
 create mode 100644 arch/arm/boot/dts/armada-370-seagate-personnal-cloud.dtsi

-- 
2.1.4
