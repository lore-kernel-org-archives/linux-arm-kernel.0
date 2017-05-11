From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 09:34:21 +0200
Subject: [PATCH v5 1/1] pinctrl: armada-37xx: Add irqchip support
In-Reply-To: <e7e0d7156844933efe5fdb997afa4cdca1ea6ec4.1493387770.git-series.gregory.clement@free-electrons.com>
References: <cover.5e6e6649efd7d0482a5df17fb7f94fde29a54210.1493387770.git-series.gregory.clement@free-electrons.com>
 <e7e0d7156844933efe5fdb997afa4cdca1ea6ec4.1493387770.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdb3iM4VUhwrH7GORtNRmQbaMCQ8s72VBWdghhXEXMtPsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 4:01 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The Armada 37xx SoCs can handle interrupt through GPIO. However it can
> only manage the edge ones.
>
> The way the interrupt are managed is classical so we can use the generic
> interrupt chip model.
>
> The only unusual "feature" is that many interrupts are connected to the
> parent interrupt controller. But we do not take advantage of this and use
> the chained irq with all of them.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied for v4.13.

Yours,
Linus Walleij
