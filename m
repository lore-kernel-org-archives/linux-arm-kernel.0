From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 15:19:49 +0200
Subject: [PATCH 1/1] pinctrl: fix pinctrl_register_mappings
In-Reply-To: <1335250763-7678-1-git-send-email-plagnioj@jcrosoft.com>
References: <1335250763-7678-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CACRpkdYjgchvKvs1Wyw9viSUtdc=ZWDtSyDDP2MatEw0_XkVBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 8:59 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> the function was to pinctrl
>
> e93bcee00c4 pinctrl: move generic functions to the pinctrl_ namespace
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>

This is already fixed in the tree I think, but thanks anyway!

-#endif /* !CONFIG_PINMUX */

We forgot to fix that comment though. I'll write a patch.

Thanks,
Linus Walleij
