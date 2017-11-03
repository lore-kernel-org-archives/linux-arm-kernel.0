From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:34 +0200
Subject: [PATCH 0/7] ARM: OMAP2+: clkctrl fixes/enhancements for omaps
Message-ID: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds some fixes/enhancements for the clkctrl support on
omap family SoCs. Required to properly support clkctrl clocks on
am3,am4,am5,omap4,omap5,dra7. Targeted for 4.16 seeing we are pretty
late on 4.14-rc cycle.

This series can be merged independently from the other serieses
(driver part support code, DTS data.) Boot tested against 4.14-rc1
on the boards I have access to.

Series has been pushed here:
Tree: https://github.com/t-kristo/linux-pm.git
Branch: 4.14-rc1-clkctrl-mach-omap2

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
