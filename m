From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Mar 2018 14:19:30 +0100
Subject: [PATCH 3/3] arm64: dts: armada-3720-espressobin: wire up LED2
In-Reply-To: <20180321105005.18426-3-u.kleine-koenig@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-3-u.kleine-koenig@pengutronix.de>
Message-ID: <20180321131930.GD11206@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 11:50:05AM +0100, Uwe Kleine-K?nig wrote:
> The led is connected to MPP1_2.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Note the LED doesn't work for me on two different boards.

Do you have a board it does work with?

> But the voltage levels on one side of the LED changes from 1.76V to
> 0V when enabling the LED. So there is probably something fishy,
> don't know if it is hardware or software related.

I think we should not apply this patch until we get a better idea why
it does not work. Is 1.76V not enough? Is the LED mounted the wrong
way around? Not enough current?

    Andrew
