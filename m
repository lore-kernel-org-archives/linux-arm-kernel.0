From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 28 Jul 2010 07:01:08 +0200
Subject: unable to use NAND02GR3B2DZA6E on i.MX27 with linux
In-Reply-To: <4C4DB6CE.6080709@bvs-tech.com>
References: <4C4DB6CE.6080709@bvs-tech.com>
Message-ID: <20100728050108.GD10506@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jul 26, 2010 at 06:24:46PM +0200, Alexis RODET wrote:
> Hello,
> 
> I have a custom board with 1 i.MX27 microcontroller and 1 Numonyx NAND
> 256MiB 1,8V 8-bit connected on the nfc port.
> I manage to read and write in that nand flash from redboot but not from
> Linux which crashes.
> I tested with Linux stable 2.6.34.1 + board support modification.
> I have tested with and without hw_ecc = 1 and get the same crash at
> send_cmd+0x20/0x34.
> Could you give me any advise to debug this ?
I would start with enabling CONFIG_MTD_DEBUG and setting
CONFIG_MTD_DEBUG_VERBOSE=3.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
