From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 02 May 2013 21:04:16 -0700
Subject: [PATCH 1/7] ARM: u300: push down syscon registers
In-Reply-To: <1367511416-4312-2-git-send-email-linus.walleij@stericsson.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
 <1367511416-4312-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130503040416.7790.51673@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-05-02 09:16:49)
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Get rid of the <mach/syscon.h> header as a prerequisite for
> multiplatform support. Do this by pushing the registers down
> to their respective drivers and deleting the unused remainder.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike: I'm seeking an ACK for this to take it through the
> ARM SoC tree alongside the big bowl of DT enablement patches.

For the clk-u300.c part:
Acked-by: Mike Turquette <mturquette@linaro.org>
