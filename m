From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 13:07:56 +0100
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <20171019131003.9684-1-gregory.clement@free-electrons.com>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdbqjh5U5QoE_B+7GfSyDdHW-NCAvogGq-2n8j6L6nG-Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 3:10 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Ken Ma <make@marvell.com>
>
> Current edge both type gpio irqs which need to swap polarity in each
> interrupt are not supported, this patch adds edge both type gpio irq
> support.
>
> Signed-off-by: Ken Ma <make@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

The discussion here is interesting, it is customary for GPIO drivers
to implement double-edge detection emulation by swapping the
edge detector around like this.

It might be possible to collect some generic information about
this in the Documentation/gpio/driver.txt document.

Yours,
Linus Walleij
