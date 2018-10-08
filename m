From: aleksandr.aleksandrov@emlid.com (Aleksandr Aleksandrov)
Date: Mon,  8 Oct 2018 18:20:41 +0300
Subject: [PATCH v3] Neutis N5 support
In-Reply-To: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
Message-ID: <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
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

Aleksandr Aleksandrov (1):
  arm64: new board - Emlid Neutis N5

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 184 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  96 +++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

-- 
2.7.4
