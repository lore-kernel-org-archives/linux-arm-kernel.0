From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Nov 2018 10:54:52 +0100
Subject: [PATCH V4 06/10] pinctrl: fsl: imx7ulp: change to use imx legacy
 binding
In-Reply-To: <1541149669-10857-7-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
 <1541149669-10857-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdZcNnm9weqZs8atEgbDVLRA4cQSL+pQ-m04Fb7Q+kv9eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2018 at 10:13 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

> We already had an earlier conclusion that all new i.MX Socs will keep
> using the legacy i.MX Pinctrl bindings instead of generic pin config.
> However, MX7ULP generic pin config binding support has already been in
> tree before that time. Per SoC maintainers' suggestions, in order to
> get a better consistency for all i.MX devices, we'd like to go back to
> imx legacy binding for MX7ULP as well.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v3: new patch

Patch applied.

Yours,
Linus Walleij
