From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Dec 2017 16:56:31 +0000
Subject: [PATCH 00/20] Add Hummingboard 2 support
Message-ID: <20171211165631.GW10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds the long awaited Hummingboard 2 support to the
mainline kernel.

While I could squash the patch set down, I've not done this because
this is the result of several different people over the course of
the last couple of years, and I believe it's not right to lose the
detail of their contributions.

This builds upon the previous set of changes for the Hummingboard,
which re-organised the way we deal with the uSOM and baseboards.

 arch/arm/boot/dts/Makefile                         |   6 +
 .../boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts |  55 +++
 arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts |  54 +++
 arch/arm/boot/dts/imx6dl-hummingboard2.dts         |  53 ++
 .../boot/dts/imx6q-hummingboard2-emmc-som-v15.dts  |  63 +++
 arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts  |  62 +++
 arch/arm/boot/dts/imx6q-hummingboard2.dts          |  61 +++
 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi  |  72 +++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       | 540 +++++++++++++++++++++
 9 files changed, 966 insertions(+)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
