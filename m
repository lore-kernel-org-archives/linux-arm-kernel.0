From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Nov 2010 15:51:31 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <20101109140455.GA6680@n2100.arm.linux.org.uk>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<20101109140455.GA6680@n2100.arm.linux.org.uk>
Message-ID: <20101109145131.GY16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:04:55PM +0000, Russell King - ARM Linux wrote:
> Is it really faster to copy an uncompressed image than it is to
> decompress using LZMA with caches on?
> 
> Remember that in terms of fast boot, uboot sucks - it's way over the
> top of what you need.  Eg, it always copies the image to RAM before
> executing it.  That gives two problems:
Last time I checked (which is a few years ago) U-Boot was well able to
start a ZBOOT_ROM image.  I'd be surprised if U-Boot lost that ability.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
