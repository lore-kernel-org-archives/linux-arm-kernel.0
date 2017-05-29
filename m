From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 18:39:06 +0200
Subject: [PATCH v3 04/10] pinctrl: sunxi: drop dedicated A20 driver
In-Reply-To: <20170527102308.1988-5-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
 <20170527102308.1988-5-icenowy@aosc.io>
Message-ID: <CACRpkdbuiemtje+Xvwjnp1+afjFMyetgNyMUtS-WsNYhpP3HSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 27, 2017 at 12:23 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> As we added A20 support to A10 pinctrl driver, now we can delete the
> dedicated A20 pinctrl driver, which is duplicated code.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - Only remove the A20 driver(A10 driver for A20 is enabled in
>   the previous commit now).

Patch applied with Chen-Yu's review tag, and I also fixed
up the Makefile by removing the rule for this file.

Yours,
Linus Walleij
