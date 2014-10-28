From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 15:21:09 +0100
Subject: [PATCH v2 2/3] pinctrl: meson: add device tree bindings
 documentation
In-Reply-To: <1413321714-25931-3-git-send-email-b.galvani@gmail.com>
References: <1413321714-25931-1-git-send-email-b.galvani@gmail.com>
 <1413321714-25931-3-git-send-email-b.galvani@gmail.com>
Message-ID: <CACRpkdbw-Rdm9PoOfbmLApJX-df5Kcmag4a=GHV58Y7T=1ykQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 11:21 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:

> Add device tree bindings documentation for Amlogic Meson pinmux and
> GPIO controller.
>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
(...)

> +               gpio_ao: ao-bank at c1108030 {
> +                       reg = <0xc8100014 0x4>,
> +                             <0xc810002c 0x4>,
> +                             <0xc8100024 0x8>;

This still has the same problem as in the previous review.

It seems for both patches you posted v2 before I got to review
v1, so sorry for the confusion.

Please take the combined result of my review letters and
fix everything...

Yours,
Linus Walleij
