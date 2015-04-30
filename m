From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 30 Apr 2015 15:30:11 +0200
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
 <20150429191228.GO15254@pengutronix.de>
 <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
Message-ID: <20150430133011.GE15254@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On Thu, Apr 30, 2015 at 12:08:53PM +0100, Liviu Dudau wrote:
> Sorry Robert, this fell through the cracks. VExpress gets very few
> patches in general and we're new to this :(

Thanks for the help!

I still see these errors with 4.1-rc1:

[    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
[    0.268626] platform 10000000.sysreg: Error -2 creating of_node link
[    0.271997] platform basic-mmio-gpio.1.auto: Error -2 creating of_node link
[    0.272266] platform basic-mmio-gpio.2.auto: Error -2 creating of_node link
[    0.272681] platform basic-mmio-gpio.3.auto: Error -2 creating of_node link
[    0.426298] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller at 100e0000
[    0.426799] of_amba_device_create(): amba_device_add() failed (-19) for /memory-controller at 100e1000
[    0.427099] of_amba_device_create(): amba_device_add() failed (-19) for /watchdog at 100e5000
[    0.433206] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga at 7,00000000/sysctl at 01000
[    0.438165] of_amba_device_create(): amba_device_add() failed (-19) for /smb/motherboard/iofpga at 7,00000000/wdt at 0f000

Do you have an idea what might go wrong?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
