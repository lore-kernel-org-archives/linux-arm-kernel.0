From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2012 01:07:20 +0200
Subject: [PATCH v4 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <1335529578-14507-2-git-send-email-b29396@freescale.com>
References: <1335529578-14507-1-git-send-email-b29396@freescale.com>
 <1335529578-14507-2-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdZce7fZ=3cWLwWXzJ30P_LoLYKXdU411zr38RNkQs0+wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 2:26 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> The driver has mux and config support while the gpio is still
> not supported.
> For select input setting, the driver will handle it internally
> and do not need user to take care of it.
>
> The pinctrl-imx core driver will parse the dts file and dynamically
> create the pinmux functions and groups.
>
> Each IMX SoC pinctrl driver should register pins with a pin register map
> including mux register and config register and select input map to core
> for proper operations.
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>

Thanks, applied.

Yours,
Linus Walleij
