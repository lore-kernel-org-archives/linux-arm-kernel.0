From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 18:39:34 +0200
Subject: [PATCH 1/6] pinctrl: add pinctrl driver for imx6dl
In-Reply-To: <1364913079-26039-2-git-send-email-shawn.guo@linaro.org>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
 <1364913079-26039-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdaoVSHQg11E6W-hVyU6ud51yoQQ8-SrgnrmiO47JqJdrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 4:31 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The imx6dl is a derivative of imx6q with very limited difference.  These
> two SoCs are so compatible that they can be handled as one platform in
> software.  That said, we will not have target SOC_IMX6DL but just
> reusing SOC_IMX6Q.   That's why the pinctrl-imx6dl driver is added here
> with symbol PINCTRL_IMX6Q controlling the build of it.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

OK Acked-by: Linus Walleij <linus.walleij@linaro.org>

Also for patch 2.

Will you take this through the Freescale tree?

Yours,
Linus Walleij
