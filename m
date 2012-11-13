From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Nov 2012 15:14:44 +0100
Subject: [PATCH] ARM: select PINCTRL for ARCH_MMP
In-Reply-To: <1352701807.15066.1.camel@phoenix>
References: <1352701807.15066.1.camel@phoenix>
Message-ID: <CACRpkdaqFB1pajpW+_+ayw++pXR=tcAx6jFLhw0BFheeAzUpmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 7:30 AM, Axel Lin <axel.lin@ingics.com> wrote:

> This makes PINCTRL related config options visible.
> Otherwise there is no way to build pinctrl drivers for MMP2, PXA168 and PXA910.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Hm weird that it's not there already,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If I get some subsystem maintainers ACK I can apply it
to the pinctrl tree.

Yours,
Linus Walleij
