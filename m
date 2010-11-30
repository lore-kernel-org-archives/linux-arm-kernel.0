From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 20:52:11 +0100
Subject: [PATCH v4 3/3] ARM: mx5: fix keypad clock name
In-Reply-To: <1291146343-25808-3-git-send-email-fabio.estevam@freescale.com>
References: <1291146343-25808-1-git-send-email-fabio.estevam@freescale.com>
	<1291146343-25808-2-git-send-email-fabio.estevam@freescale.com>
	<1291146343-25808-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101130195211.GX20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Nov 30, 2010 at 05:45:43PM -0200, Fabio Estevam wrote:
> After moving to dynamically registration of the keypad, the keypad clock
> name needs to change accordingly.
> 
> The reason is that the original mx5 keypad platform_device id was 0, 
> now we use id=-1 as per arch/arm/plat-mxc/devices/platform-imx-keypad.c.
> 
> Tested keypad successfully on a MX51_3DS board.
I'd squash that into the previous patch otherwise your keypad doesn't
work for one commit.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
