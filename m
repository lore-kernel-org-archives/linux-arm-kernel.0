From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Dec 2015 01:23:08 +0100
Subject: [GIT PULL v2] Reset controller changes for v4.5
In-Reply-To: <1449154761.3339.40.camel@pengutronix.de>
References: <1449154761.3339.40.camel@pengutronix.de>
Message-ID: <1511709.Ume7y8iodG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 15:59:21 Philipp Zabel wrote:
> Reset controller changes for v4.5 v2
> 
> - oftree support for getting reset devices by index
> - fixed return value consistency of of_reset_control_get
> - added support for STi co-processor resets
> - added STi status callback
> - added HiSilicon Hi6220 reset driver
> - added ath79 system restart support
> - various fixes

Merged into next/drivers, thanks!

	Arnd
