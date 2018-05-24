From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 May 2018 10:17:06 +0200
Subject: [PATCH] pinctrl: armada-37xx: Fix spurious irq management
In-Reply-To: <20180523084405.14410-1-gregory.clement@bootlin.com>
References: <20180523084405.14410-1-gregory.clement@bootlin.com>
Message-ID: <CACRpkdak2q56BpjrvpGF_FzN=ZTbZ+71r425rFAe=b-kRQDqwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 10:44 AM, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> From: Terry Zhou <bjzhou@marvell.com>
>
> Until now, if we found spurious irq in irq_handler, we only updated the
> status in register but not the status in the code. Due to this the system
> will got stuck dues to the infinite loop
>
> [gregory.clement at bootlin.com: update comment and add fix and stable tags]
> Fixes: 30ac0d3b0702 ("pinctrl: armada-37xx: Add edge both type gpio irq support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Patch applied.

Yours,
Linus Walleij
