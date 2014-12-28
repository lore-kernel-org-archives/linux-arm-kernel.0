From: evgeni@studio-punkt.com (Evgeni Dobrev)
Date: Sun, 28 Dec 2014 11:46:27 +0100
Subject: [PATCH v4 0/1] add support for Seagate BlackArmor NAS220
In-Reply-To: <20141215203855.GA28940@anne>
References: <20141215203855.GA28940@anne>
Message-ID: <20141228104627.GA11475@anne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4:	rename basename to blackarmor-nas220
	use "Seagate Blackarmor NAS220" as model name
	use node references instead of repeating the bus structure
	separate nodes with blank lines
	adt7476's node name reflects device function (i.e. thermal)
	reduce button labels to "Reset" and "Power"
	use GPIO_ACTIVE_LOW for regulator's gpio property

v3:	documented UART pinout in dts

v2:	indent with tabs only
	removed NAND layout

Evgeni Dobrev (1):
  add support for Seagate BlackArmor NAS220

 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts |  172 ++++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts

-- 
1.7.10.4
