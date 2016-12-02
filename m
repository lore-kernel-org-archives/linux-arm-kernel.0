From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri,  2 Dec 2016 10:08:38 +0100
Subject: [PATCH 0/5] ARM: dts: boundary: remove hardcoded LVDS bus format
Message-ID: <20161202090843.22613-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series removes the hardcoded bus format for the LVDS display nodes of our
platforms.

The reason is that our latest 7" display uses a 24-bit interface and therefore
can't work properly without this series.
https://patchwork.kernel.org/patch/9458053/

Regards,
Gary

Gary Bisson (5):
  ARM: dts: imx6qdl-nit6xlite: remove hardcoded LVDS bus format
  ARM: dts: imx6qdl-nitrogen6_max: remove hardcoded LVDS bus format
  ARM: dts: imx6qdl-nitrogen6_som2: remove hardcoded LVDS bus format
  ARM: dts: imx6qdl-nitrogen6x: remove hardcoded LVDS bus format
  ARM: dts: imx6qdl-sabrelite: remove hardcoded LVDS bus format

 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi      | 2 --
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi  | 4 ----
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 2 --
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi     | 2 --
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi      | 2 --
 5 files changed, 12 deletions(-)

-- 
2.9.3
