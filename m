From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 17:48:23 +0200
Subject: [PATCH v2] pinctrl: rockchip: correctly handle arguments of
 pinconf options
In-Reply-To: <201306161741.17048.heiko@sntech.de>
References: <201306141741.46077.heiko@sntech.de>
 <201306161302.32156.heiko@sntech.de>
 <CACRpkdZxO-8rQPBRPsxAx8OBfwvh_BQuts7NAi379gMZG+1ocg@mail.gmail.com>
 <201306161741.17048.heiko@sntech.de>
Message-ID: <CACRpkdZx9pjfqzn_keKTGGPsP1jHOY2=4OQX9mmymeo9EPn=Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 5:41 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Change the rockchip pinctrl driver to handle the arguments to the pull
> pinconfig options correctly. So only accept non-0 values for the
> pull options as the rockchip pin-controller can only turn pulls on and
> off (this via BIAS_DISABLE).
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
>  really respect the values for arguments of the pull options (aka 0 is not
>  meant to turn off a pull).
>  Replacing the patch also makes sure that no wrong knowledge stays in the
>  kernel via the old commit message, least somebody else reads it and takes
>  it as true.

OK took out the v1 and put in this v2 version instead...

Thanks!
Linus Walleij
