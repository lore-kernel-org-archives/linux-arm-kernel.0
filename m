From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Mar 2013 14:14:04 +0100
Subject: [PATCH 4/6] pinctrl: sunxi: add clock support
In-Reply-To: <1363962042-29536-5-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1363962042-29536-5-git-send-email-emilio@elopez.com.ar>
Message-ID: <CACRpkdbn9c_bAWUN8hTLkeidCnyZ=0nRQRBV39DMkK_0jBfoUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 3:20 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:

> For the port controller to work, we need to enable the apb0_pio gate.
> This commit adds the ability to enable one clock specified on the device
> tree to the pinctrl driver.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you'll want to merge these as one series to some platform-specific
tree, tell me if you want it merged in the pinctrl tree.

Yours,
Linus Walleij
