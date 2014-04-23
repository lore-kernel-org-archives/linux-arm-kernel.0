From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 16:17:03 +0200
Subject: [PATCH v2 03/38] pinctrl: mvebu: new driver for Orion platforms
In-Reply-To: <1398202002-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaDLJitKqrYrbnEdiSqM1XQoAwT2AffRX0z+o70gmPTYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 11:26 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit extends the pinctrl mvebu logic with a new driver to cover
> Orion5x SoC. It supports the definitions for the 5181l, 5182 and 5281
> variants of Orion5x, which are the three ones supported by the old
> style MPP code in arch/arm/mach-orion5x/.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Nothing very controversial about this, shall I just apply it or do you need
it to be kept together with other stuff?

Yours,
Linus Walleij
