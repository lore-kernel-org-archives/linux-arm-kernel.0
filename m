From: const@makelinux.com (Constantine Shulyupin)
Date: Mon, 12 Nov 2012 00:38:37 +0200
Subject: Porting board initialization for fdt
Message-ID: <CAE7jHC-Z9wy=5HPzhZZpupcBVn862ERq1LRF9KQ=Ed7BXiDFBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What is architecture and the best strategy to port board initialization to fdt?

Let's see for example omap4_ehci_init and usbhs_bdata @
arch/arm/mach-omap2/board-omap4panda.c.

How to perform board specific initializations?
Can omap4_ehci_init be converted to probe function of new platform
driver  omap4_ehci?
Where and how define GPIO, clock?
Should it be defined in of_dev_auxdata or in fdt?

Thanks

-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems
