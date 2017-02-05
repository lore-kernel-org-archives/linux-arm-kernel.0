From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Feb 2017 15:36:41 +0100
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <alpine.LNX.2.00.1702051054240.26313@T420s>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
 <alpine.LNX.2.00.1702051054240.26313@T420s>
Message-ID: <CACRpkdY=gc4R5RwgPrFnjyfLVqgN0=ChVe6D7ibvAA+8Q1sqNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 5, 2017 at 11:00 AM, Hans Ulli Kroll
<ulli.kroll@googlemail.com> wrote:

> irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller at 48000000!
>
> We need to use the use the use the PCI IRQ from gemini as root for the irq
> domain, not the next one in DT.

Hm I wonder if that is because I need to set the parent for the intcon
in the device tree as Arnd pointed out in the bindings patch?

Yours,
Linus Walleij
