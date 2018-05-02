From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 May 2018 14:23:11 +0200
Subject: [PATCH 2/6] pinctrl: pinctrl-imx: improve the code comments of
 PIN_FUNC_ID
In-Reply-To: <1524855713-15527-3-git-send-email-aisheng.dong@nxp.com>
References: <1524855713-15527-1-git-send-email-aisheng.dong@nxp.com>
 <1524855713-15527-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdbHU49+3Dq6CQaYZc+JYQ+4OPgT4iwJ4=ucV=oQWNEgeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 9:01 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The current code comments of PIN_FUNC_ID actually is not true for
> SHARE_MUX_CONF_REG case which should be a 4 u32 PIN_FUNC_ID.
> Fix the comments and re-org it a bit for better extendibility
> as we may add a different size for SCU based PIN_FUNC_ID later.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
