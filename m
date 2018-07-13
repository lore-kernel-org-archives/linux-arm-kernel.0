From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Fri, 13 Jul 2018 14:49:01 +0200
Subject: [PATCH 0/3] ARM: dts: imx: Update Boundary Devices boards
Message-ID: <20180713124904.9285-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series udpates the device tree files for all Boundary Devices
boards.

It consists of two main changes:
1. Switch to SPDX identifier
2. Update boards relying on MXSFB driver not to block the switch to DRM
driver instead of FBDEV [1].

Let me know if you have any question.

Regards,
Gary

[1] https://patchwork.kernel.org/patch/10467487/

Gary Bisson (3):
  ARM: dts: imx: Switch Boundary Devices boards to SPDX identifier
  ARM: dts: imx7d-nitrogen7: use OF graph to describe the display
  ARM: dts: imx6sx-nitrogen6sx: remove obsolete display configuration

 arch/arm/boot/dts/imx6dl-nit6xlite.dts        |  38 +-----
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts       |  38 +-----
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts     |  38 +-----
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts    |  38 +-----
 arch/arm/boot/dts/imx6q-nitrogen6x.dts        |  38 +-----
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi      |  38 +-----
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi  |  38 +-----
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi |  38 +-----
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi     |  38 +-----
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts    |  39 +------
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts   |  39 +------
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts      | 109 +-----------------
 arch/arm/boot/dts/imx7d-nitrogen7.dts         |  87 +++-----------
 13 files changed, 28 insertions(+), 588 deletions(-)

-- 
2.18.0
