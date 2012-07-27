From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Jul 2012 01:00:41 +0200
Subject: [PATCH] pinctrl: mxs: register driver at postcore_initcall time
In-Reply-To: <1342687270-32600-1-git-send-email-shawn.guo@linaro.org>
References: <1342687270-32600-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdbyx04Bai4DnnNjSM=NdXgWeK5zgMvYPsXpmGDQuZjG4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 10:41 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> It's not so usual, but there are still some cases which require pinctrl
> driver function at arch_initcall time.  So register imx23 and imx28
> pinctrl driver at postcore_initcall time.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied to fixes branch.

Yours,
Linus Walleij
