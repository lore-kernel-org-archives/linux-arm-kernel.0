From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 12:40:58 +0100
Subject: [PATCH 1/2] pinctrl: exynos: Add AUDIO pin controller for exynos7
In-Reply-To: <1418994659-5222-2-git-send-email-padma.v@samsung.com>
References: <1418994659-5222-1-git-send-email-padma.v@samsung.com>
 <1418994659-5222-2-git-send-email-padma.v@samsung.com>
Message-ID: <CACRpkdZopjCN_GMEPQFd_NWa0Ddocqt3aViLrZ7Yh3ui_YcBAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 2:10 PM, Padmavathi Venna <padma.v@samsung.com> wrote:

> Audio IPs on Exynos7 require gpios available in AUDIO
> pin controller block. So adding the AUDIO pinctrl support.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
(...)
> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> @@ -181,6 +181,7 @@ Aliases for controllers compatible with "samsung,exynos7-pinctrl":
>  - pinctrl6: pin controller of FSYS0 block,
>  - pinctrl7: pin controller of FSYS1 block,
>  - pinctrl8: pin controller of BUS1 block,
> +- pinctrl9: pin controller of AUDIO block,

This doesn't apply at all, the list has never been in the document merged
upstream.

Please prepare this patch rebased on a *CLEAN* upstream tree
and resend.

Include Tomasz ACK on your repost.

Yours,
Linus Walleij
