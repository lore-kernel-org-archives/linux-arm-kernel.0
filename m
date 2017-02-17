From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 17 Feb 2017 13:36:08 +0100
Subject: [PATCH] pata: remove the at91 driver
In-Reply-To: <1487324200-17517-1-git-send-email-boris.brezillon@free-electrons.com>
References: <CGME20170217093732epcas5p463c32b21e7c71000d01d15c54333c1f6@epcas5p4.samsung.com>
 <1487324200-17517-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1599704.hbkP4KrUDJ@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Friday, February 17, 2017 10:36:40 AM Boris Brezillon wrote:
> This driver is orphan since commit 2e591e7b3ac2 ("ARM: at91: remove
> at91sam9261/at91sam9g10 legacy board support"). Given that nobody cared
> adding DT support to it, it probably means it's no longer used and is
> thus a good candidate for removal.

The exact commit which removed PATA support for AT91SAM9260 seems to
be b2026f708e09 ("ARM: at91: remove at91sam9260/at91sam9g20 legacy
board support").

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
> Note that I'm removing this driver because I plan to rework the macro
> definitions in atmel-smc.h, and some of them are used in this driver.
> Since I can't test it, and this drivers is not used anymore, it's probably
> better to remove it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
