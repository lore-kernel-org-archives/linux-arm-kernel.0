From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 28 Sep 2014 11:08:38 +0200
Subject: [PATCH] pinctrl: remove remaining users of gpiochip_remove()
 retval
In-Reply-To: <1410905274-22339-1-git-send-email-linus.walleij@linaro.org>
References: <1410905274-22339-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140928090838.GD31554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On Tue, Sep 16, 2014 at 03:07:54PM -0700, Linus Walleij wrote:
> Some drivers accidentally still use the return value from
> gpiochip_remove(). Get rid of them so we can simplify this function
> and get rid of the return value.
> 
> Abdoulaye Berthe <berthe.ab@gmail.com>
Is there a "Signed-off-by: " (or an other tag) missing?

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
