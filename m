From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2012 01:19:36 +0200
Subject: [PATCH v2] pinctrl: add pinctrl-mxs support
In-Reply-To: <1335589250-25065-1-git-send-email-shawn.guo@linaro.org>
References: <1335589250-25065-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdakZkqfPC-OShh3xLXaLaxwJmOBNMYvSa_85_fU1P9sdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 28, 2012 at 7:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> The driver supports device tree probe only.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
> * Improve binding document
> * Add missing MODULE_DEVICE_TABLE for imx23_pinctrl_of_match and
> ?imx28_pinctrl_of_match

Thanks Shawn, applied with Stepgen's ACK.

Yours,
Linus Walleij
