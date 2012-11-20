From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 15:44:35 +0100
Subject: [PATCH v5 02/10] pinctrl: single: support gpio request and free
In-Reply-To: <1352968600-15345-3-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CACRpkdZQ3D+KFEWqptZNbnw_eqwWFqBejwAgmXLHa0MHNNsy_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 9:36 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:

> Marvell's PXA/MMP silicon also match the behavior of pinctrl-single.
> Each pin binds to one register. A lot of pins could be configured
> as gpio.
>
> GPIO range is defined as a child node of pinmux in .dtsi file. If those
> pins are with the same gpio function configuration in the pinmux
> register, they could be defined in the same GPIO range. For this new
> child node, two properties are used.
>
> reg = <the start of pinmux register in range, size of range>
>
> pinctrl-single,gpio: <gpio base in range, the gpio function of the range
>                 in the pinmux register>
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
