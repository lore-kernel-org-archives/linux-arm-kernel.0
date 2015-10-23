From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 10:21:01 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <5627BDB6.6020501@gmail.com>
References: <5627BDB6.6020501@gmail.com>
Message-ID: <CACRpkdbMq65VA8B9ZKB19Rh6dv2HxOG5VAV4VcMAGJs64L-W=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 6:30 PM, Jens Kuske <jenskuske@gmail.com> wrote:

> The H3 uses the same pin controller as previous SoC's from Allwinner.
> Add support for the pins controlled by the main PIO controller.
>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>

This does not apply to my "devel" branch on the pinctrl tree.
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Please rebase it on the devel branch, add Maxime's ACKs and
resend so I can apply it.

Yours,
Linus Walleij
