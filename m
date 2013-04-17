From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 17 Apr 2013 16:35:59 -0400
Subject: [PATCH 0/3] arm: omap: add ti bandap device on DT entries
Message-ID: <1366230959-31694-1-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit, Tony,

This is a small series, based on linux-next, that adds
ti bandgap device. This is based on previous reviews this
driver got.

The driver is still under staging, I believe it is in a good
shape to be enabled and start broader tests.

I have tested this driver on OMAP4430/60 and OMAP5430.

This series will contain only the part that is required to
add its device tree node entry.

All best,

Eduardo Valentin (3):
  arm: dts: introduce config HAS_BANDGAP
  arm: dts: add bandgap entry for OMAP443x devices
  arm: add bandgap entry for OMAP4460 devices

 arch/arm/Kconfig                | 3 +++
 arch/arm/boot/dts/omap443x.dtsi | 4 ++++
 arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
 arch/arm/mach-omap2/Kconfig     | 1 +
 4 files changed, 17 insertions(+)

-- 
1.8.2.1.342.gfa7285d
