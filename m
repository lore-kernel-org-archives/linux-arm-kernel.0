From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jan 2017 15:02:01 +0000
Subject: [PATCH RFC 0/4] SolidRun Hummingboard 2 support
Message-ID: <20170108150201.GS14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for SolidRun's Hummingboard 2 to mainline.
The first is the official SolidRun DTS file supplied by Jon, the
remainder are cleanups to it for mainline.

These can be found in my HB2 branch.

 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx6dl-hummingboard2.dts   |  52 +++
 arch/arm/boot/dts/imx6q-hummingboard2.dts    |  60 +++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 562 +++++++++++++++++++++++++++
 4 files changed, 676 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
