From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 24 Apr 2012 22:37:49 +0800
Subject: [PATCH] pinctrl: fix dangling comment
In-Reply-To: <1335273676-22212-1-git-send-email-linus.walleij@stericsson.com>
References: <1335273676-22212-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120424143748.GD24122@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2012 at 03:21:16PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This comment was referring to an older PINMUX define, it should
> be PINCTRL now.
> 
> Reported-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  include/linux/pinctrl/machine.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Yes, we missed it before.
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
