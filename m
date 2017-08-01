From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 13:55:50 +0200
Subject: [PATCH V4 RESEND 5/6] pinctrl: imx: make
 imx_pmx_ops.gpio_set_direction platform specific callbacks
In-Reply-To: <1500990116-3620-6-git-send-email-aisheng.dong@nxp.com>
References: <1500990116-3620-1-git-send-email-aisheng.dong@nxp.com>
 <1500990116-3620-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkda-Gv2psw5CyzN8YQOXU_aEERbo-T90dS5LQh_rtALHGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 3:41 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> Various IMX platforms may have different imx_pmx_ops.gpio_set_direction
> implementations, so let's make it platform specific callbacks instead of
> the fixed common one.
>
> Currently only VF610 platform implements it. No function level changes.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
