From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Jul 2013 14:26:08 +0200
Subject: kernel makefile
In-Reply-To: <CANEcUBV0k_JgDyO6-MAzAqX3EwaL77ctwPRSzdkHD-qc-eJPEw@mail.gmail.com>
References: <CANEcUBV0k_JgDyO6-MAzAqX3EwaL77ctwPRSzdkHD-qc-eJPEw@mail.gmail.com>
Message-ID: <20130730122608.GS1754@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 30, 2013 at 08:19:08PM +0800, zhaobin xv wrote:
> in arch/arm/boot/Makefile:
> there is some makefile code:
> 
> ifeq ($(CONFIG_ZBOOT_ROM),y)
> $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
> else
> $(obj)/uImage: LOADADDR=$(ZRELADDR)
> endif
> 
> $(obj)/uImage: STARTADDR=$(LOADADDR)
> 
> I can't understand the makefile syntax:$(obj)/uImage: STARTADDR=$(LOADADDR),
> I can't find the syntax in GNU make Version 3.82
> where can I find the syntax
Check

	info make 'Target-specific'
	
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
