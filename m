From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 10 Sep 2012 13:10:10 -0700
Subject: [PATCH 06/11] clk: Common clocks implementation for Versatile
 Express
In-Reply-To: <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-7-git-send-email-pawel.moll@arm.com>
Message-ID: <20120910201010.20289.46429@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2012-09-03 09:25:26)
> This patch adds a DT and non-DT based implementation of
> the common clock infrastructure for Versatile Express
> platform. It registers (statically or using DT) all
> required fixed clocks, initialises motherboard's SP810
> cell (that provides clocks for SP804 timers) and
> explicitely registers VE "osc" driver, to make the
> clock generators availalable early.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Barring the DT-related comments by Arnd and others, the common
clk-specific changes in this patch look good to me.  Which tree will
this patch go through?  (same question I asked on patch 5)

Regards,
Mike
