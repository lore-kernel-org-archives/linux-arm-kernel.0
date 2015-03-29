From: davem@davemloft.net (David Miller)
Date: Sun, 29 Mar 2015 13:41:01 -0700 (PDT)
Subject: [PATCH] net: fec: setup right value for mdio hold time
In-Reply-To: <1427450912-9793-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1427450912-9793-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150329.134101.916097441015561162.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Date: Fri, 27 Mar 2015 11:08:32 +0100

> The FEC modules used on i.MX28 and newer have a register to tune the MDIO
> output hold time that should be at least 10 ns. Up to now this value was not
> explicitly set and so resulted in less hold time if the fec clock was
> faster than 100 MHz.
> 
> This was noticed on an i.MX28 machine that uses an input clock of ~150
> Mhz which resulted in unreliable communication with a Marvell switch.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied.
