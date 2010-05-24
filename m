From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Mon, 24 May 2010 23:08:46 +0200
Subject: [PATCH 09/16] arm/mx2/mbimx27: compile fixes
	with	CONFIG_TOUCHSCREEN_ADS7846=y
In-Reply-To: <20100524203428.GB29092@pengutronix.de>
References: <20100524195430.GA28403@pengutronix.de>	<1274730951-29106-9-git-send-email-u.kleine-koenig@pengutronix.de>	<4BFADD4F.80309@eukrea.com>
	<20100524203428.GB29092@pengutronix.de>
Message-ID: <4BFAEADE.5040000@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 24/05/2010 22:34, Uwe Kleine-K?nig a ?crit :
> What do you think about adding TOUCHSCREEN_ADS7846=m to mx27_defconfig?
>
in fact I also sent a patch to update the defconfig for our boards's 
peripherals (for our board : 8250, ADS7846, libertas, LEDs, keyboard + 
for most iMX27 boards : SPI, LCD, USB host + Gadget) :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/015833.html

As a default, I put +CONFIG_TOUCHSCREEN_ADS7846=y : is it a problem to 
have it integrated and not configured as a module in the defconfig ?

Thanks,
Eric
