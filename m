From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2011 16:05:14 +0200
Subject: [PATCH 1/2] mmc: core: clarify how to use post_req in case of
	errors
In-Reply-To: <1314624959-4634-2-git-send-email-per.forlin@linaro.org>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
	<1314624959-4634-2-git-send-email-per.forlin@linaro.org>
Message-ID: <CACRpkdZJq1C4TyXbW7WuV3xgC1AhV-3aL0L8+svrPYi_FhT_Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 3:35 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The err condition in post_req() is set to undo a call made
> to pre_req() that hasn't been started yet.
> The err condition is not set if an MMC request returns error.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>

Comments look correct so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
