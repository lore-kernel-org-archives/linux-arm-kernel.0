From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 15:45:54 -0700
Subject: [PATCH 0/3] ARM: DTS: misc. OMAP3 fixes for proper wakeup
Message-ID: <1370040357-25794-1-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

Here are handful of DT updates while working on getting PM functionality
working for DT boot on OMAP3.

Kevin


Kevin Hilman (3):
  ARM: DTS: OMAP3: beagle/overo: mux console UART, enable wakeup
  ARM: DTS: OMAP3: beagle: enable user button via gpio_keys, enable
    wakeup
  ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line

 arch/arm/boot/dts/omap3-beagle-xm.dts | 39 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 37 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi    | 14 +++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        | 17 +++++++++++++++
 4 files changed, 107 insertions(+)

-- 
1.8.2
