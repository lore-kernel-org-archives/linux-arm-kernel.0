From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 12 Jan 2017 09:44:54 -0600
Subject: [PATCH] bus: qcom_ebi2: default y if ARCH_QCOM
In-Reply-To: <20170112070855.22214-1-linus.walleij@linaro.org>
References: <20170112070855.22214-1-linus.walleij@linaro.org>
Message-ID: <20170112154454.GG5710@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 08:08:55AM +0100, Linus Walleij wrote:
> Since we want this external bus to be available on multi_v7 builds,
> set to default ARCH_QCOM so we get it selected whenever QCOM is
> enabled.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Andy: I guess you could queue this to ARM SoC, they seem so manage
> drivers/bus from there.

No worries.  I'll add this to my list.


Thanks,

Andy
