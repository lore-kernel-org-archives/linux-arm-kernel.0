From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 5 Jun 2016 13:47:18 -0500
Subject: [PATCH] ARM: defconfig: enable the MSM8660 pin controller
In-Reply-To: <1464771296-8329-1-git-send-email-linus.walleij@linaro.org>
References: <1464771296-8329-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160605184718.GE13357@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 10:54:56AM +0200, Linus Walleij wrote:
> After enabling this I get pins, GPIO, keys and everything on
> the MSM8660 surf (APQ8660 DragonBoard).
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)

I'll queue this one up for my dt pull request.  Thanks!


Andy
