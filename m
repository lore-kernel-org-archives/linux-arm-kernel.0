From: aleksandr.aleksandrov@emlid.com (Aleksandr Aleksandrov)
Date: Mon, 15 Oct 2018 14:49:48 +0300
Subject: [PATCH v5 0/2] Neutis N5 support
In-Reply-To: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
Message-ID: <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch addes Neutis N5 support.
Emlid Neutis N5 is a SoM based on Allwinner H5.
The patch includes device tree file for Dev board
and dtsi file for SoM needs.

Changes from v1: separate dts file: dtsi for SoM
and motherboard dts file that inlcudes dtsi file.

Changes from v2 (5 oct 2018):
- makefile: dtb-$(CONFIG_ARCH_SUNXI) - ordered alphabetically

Changes from v3 (12 oct 2018):
- fix commit prefix for 1/2 patch
- use an SPDX header instead of the full license text
- compatible: "emlid,neutis-n5" instead of "emlid,emlid-neutis-n5"

Changes from v4 (15 oct 2018):
- fix dt-bindings commit prefix
- update license header for dts files
- make interfaces be alphabetically in devboard dts file

Aleksandr Aleksandrov (2):
  dt-bindings: vendor-prefix: new vendor - Emlid
  arm64: dts: allwinner: new board - Emlid Neutis N5

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 149 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  61 +++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

-- 
2.7.4
