From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Nov 2013 10:44:58 +0100
Subject: [PATCH] ARM: u300: fix timekeeping when periodic mode is used
In-Reply-To: <1383642199-11473-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642199-11473-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdZrV7fPcyNeBdzhhZHDkm1ZmixwDi=1=vKnFOBiYTQYsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 10:03 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> To determine the value to write to the hardware's timer counter register
> the symbol CLOCK_TICK_RATE is used. This value is a dummy value on u300
> though. So instead use the clock rate that is used for oneshot mode.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks, patch applied to the u300 branch in the linux-stericsson
tree.

Yours,
Linus Walleij
