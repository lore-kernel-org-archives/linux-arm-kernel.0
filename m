From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Thu, 19 Jan 2017 15:50:45 +0100
Subject: [PATCH v1 0/3] [for arm-soc] mach-tango DT updates for v4.11
Message-ID: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Here are my DT updates for tango4.

I also have local changes for NAND and DMA nodes, but the DMA driver
is not upstream yet, so it seems there's no point in sending these.

Marc Gonzalez (3):
  ARM: dts: tango4: Add alias for eth0
  ARM: dts: tango4: Import MMC nodes
  ARM: dts: tango4: Import USB nodes

 arch/arm/boot/dts/tango4-common.dtsi      | 46 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/tango4-vantage-1172.dts |  5 ++++
 2 files changed, 51 insertions(+)
