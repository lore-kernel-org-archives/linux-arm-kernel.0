From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 07 Aug 2017 12:08:34 +0200
Subject: [PATCH] Revert "reset: Add a Gemini reset controller"
In-Reply-To: <20170804203232.25230-1-linus.walleij@linaro.org>
References: <20170804203232.25230-1-linus.walleij@linaro.org>
Message-ID: <1502100514.2490.9.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-04 at 22:32 +0200, Linus Walleij wrote:
> This reverts commit 2acb037fc42b8ce5ae59a7d5db3c9b35672e3dd7.
> 
> We ended up merging the reset controller into the clock
> controller so we can now get rid of this stand-alone
> implementation.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to reset/next, thank you.

regards
Philipp
