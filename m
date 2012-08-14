From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 10:13:12 +0200
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZL6efwvUyW1+2j8253WRXm3WYyDUw8rN_o9QE=HER4wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 4:47 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Unlike imx6q pinctrl driver that starts nubmering pad from 0, imx5
> pinctrl drivers number pad from 1.  It causes problem/confusion when
> driver accesses imx51_pinctrl_pads array using pin ID as the index.
>
> Change imx51_pads and imx53_pads numbering start from 0.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Looks like a good idea.

Since I just merged the imx53 driver which *again* start numbering on
1, can I have a patch that fixes that driver also?

Uwe, you OK with this?

Yours,
Linus Walleij
