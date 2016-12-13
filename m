From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Dec 2016 09:08:16 +0100
Subject: [RFC PATCH 00/23] arm: defconfigs: use kconfig fragments
In-Reply-To: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20161213080816.dafyhoqhodytyy3j@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Tue, Dec 06, 2016 at 01:38:35PM +0100, Bartlomiej Zolnierkiewicz wrote:
> This RFC patchset starts convertion of ARM defconfigs to use kconfig
> fragments and dynamically generate defconfigs.  The goals of this
> work are to:
> 
> - remove duplication between defconfigs
> 
> - add a possibility to generate board/SoC/SoC-family/Multi specific
>   defconfigs in the future (without duplicating defconfigs)

what is the main use case for defconfigs? If it's the start point for
users to get a working configuration for their machine, the idea might
be fine. If however todays most important use case is build coverage,
it's even a disadvantage to make the different configs more uniform.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
