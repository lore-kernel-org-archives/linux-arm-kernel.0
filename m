From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Feb 2016 16:42:04 +0100
Subject: [PATCH v5] pinctrl: rockchip: add support for the rk3399
In-Reply-To: <1454295501-32165-1-git-send-email-david.wu@rock-chips.com>
References: <1454295501-32165-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CACRpkdYsYse-EYQ2YJFbRRMVrfp-0k-CctvCZtGtzNgJNyo1Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 3:58 AM, David Wu <david.wu@rock-chips.com> wrote:

> The pinctrl of rk3399 is much different from other's,
> especially the 3bits of drive strength.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Changes in v5:
> - merge the binding-doc-addition in one patch (Linus Heiko)
> - fix the comment of bit15 drive setting (Heiko)

Patch applied.

Yours,
Linus Walleij
