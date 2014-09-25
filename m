From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Sep 2014 08:26:48 +0200
Subject: [RFC PATCH] ARM: at91: remove no-MMU at91x40 support
In-Reply-To: <1411568281-3924-1-git-send-email-nicolas.ferre@atmel.com>
References: <1411568281-3924-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20140925062648.GJ3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas,

On Wed, Sep 24, 2014 at 04:18:01PM +0200, Nicolas Ferre wrote:
> As there is currently no-one to take care of this old !MMU target and as its
> support in recent kernels is a bit rotten, remove this at91x40 support and the
> board file associated with it (at91eb01).
> There are modern ARM !MMU in Mainline now so this target is not interesting for
s/Mainline/mainline/

> building tests anymore. It would be better to start from these modern ARM !MMU
> platforms to reintroduce at91x40 support if needed.
This last sentence doesn't sound convincing. at91x40 is an ARM7TDMI
while the "modern ARM !MMU" targets base on Cortex-M.

Anyhow, the change is fine, so:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
