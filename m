From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 22:59:07 -0400
Subject: [PATCH 0/6] OMAP/Davinci debug UART code cleanup
Message-ID: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's remove some of the most offending parts of this code.

[PATCH 1/6] ARM: add an extra temp register to the addruart low level debugging macro
[PATCH 2/6] ARM: plat-omap: make OMAP_UART_INFO into a relative offset
[PATCH 3/6] ARM: mach-omap1: clean up debug-macro.S
[PATCH 4/6] ARM: mach-omap2: clean up debug-macro.S
[PATCH 5/6] ARM: mach-davinci: make DAVINCI_UART_INFO into a relative offset
[PATCH 6/6] ARM: mach-davinci: clean up debug-macro.S


Nicolas
