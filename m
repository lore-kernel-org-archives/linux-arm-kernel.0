From: evgeni@studio-punkt.com (Evgeni Dobrev)
Date: Mon, 22 Dec 2014 13:57:35 +0100
Subject: [PATCH v3 0/1] add support for Seagate BlackArmor NAS220
In-Reply-To: <20141215203855.GA28940@anne>
References: <20141215203855.GA28940@anne>
Message-ID: <20141222125735.GA29062@anne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3:	documented UART pinout in dts

v2:	indent with tabs only
	removed NAND layout

Evgeni Dobrev (1):
  add support for Seagate BlackArmor NAS220

 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/kirkwood-nas220.dts |  166 +++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nas220.dts

-- 
1.7.10.4
