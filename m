From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 22 Oct 2011 18:41:42 +0200
Subject: [PATCH] spi/pl022: Enable clock in probe an use runtime_idle
In-Reply-To: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
References: <1319206124-17549-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdY2Csh58QbtnfYikr-VtYR_wDRfC2_X_+wR3OPhgTBE3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2011 at 4:08 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> Since we are always runtime resumed when leaving probe
> the clock must be enabled. To accomplish that we are able
> to be runtime suspended after probe in the case when no
> request is going to be recieved, a runtime_idle function
> has been implemented.
>
> Change-Id: I6cb86f2cad30ecaab16f512daf4674b039b18213
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-on: http://gerrit.lud.stericsson.com/gerrit/34447

Skip the gerrit weirdo stuff.

Notice that this patch cannot be merged until Russell's
AMBA PM patches are merged, so put this in Russell's
patch tracker so he can put it on his AMBA PM branch.

But looks correct.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
