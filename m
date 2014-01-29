From: nm@ti.com (Nishanth Menon)
Date: Wed, 29 Jan 2014 12:19:15 -0600
Subject: [PATCH 0/2] ARM: dts/OMAP: add cpu clock nodes
Message-ID: <1391019557-22313-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock nodes for all existing OMAP platforms where cpufreq-cpu0
can be used.

Sanity tested with linux next-20140128 tag, applies on
master 0e47c96 Merge tag 'for-linus-20140127' of git://git.infradead.org/linux-mtd

Ofcourse, I have send 7 different versions[1] previously, so I will start from
version 1 again considering that I have finally based on master.

If folks feel that the clock nodes must be split out into various platforms, I
can regenerate the series again.

Nishanth Menon (2):
  clk: ti: am335x: remove unecessary cpu0 clk node
  ARM: dts: OMAP3+: add clock nodes for CPU

 arch/arm/boot/dts/am33xx.dtsi |    4 ++++
 arch/arm/boot/dts/am4372.dtsi |    5 +++++
 arch/arm/boot/dts/dra7.dtsi   |    5 +++++
 arch/arm/boot/dts/omap3.dtsi  |    5 +++++
 arch/arm/boot/dts/omap4.dtsi  |    5 +++++
 arch/arm/boot/dts/omap5.dtsi  |    6 ++++++
 drivers/clk/ti/clk-33xx.c     |    1 -
 7 files changed, 30 insertions(+), 1 deletion(-)

[1] Last version of the patch series was posted here:
	http://marc.info/?l=linux-omap&m=138245695726479&w=2
-- 
1.7.9.5

Regards,
Nishanth Menon
