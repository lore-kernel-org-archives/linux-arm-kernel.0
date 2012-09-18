From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2012 14:11:32 +0200
Subject: [PATCH v2 2/2] ARM: OMAP2+: Enable pinctrl dummy states
In-Reply-To: <1347902538-21208-3-git-send-email-mporter@ti.com>
References: <1347902538-21208-1-git-send-email-mporter@ti.com>
 <1347902538-21208-3-git-send-email-mporter@ti.com>
Message-ID: <CACRpkdagKxUD2QUYLJxh_R6QjAU-jDXsG=8TxJS-Vs_k_8ir_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 7:22 PM, Matt Porter <mporter@ti.com> wrote:

> Enable pinctrl dummy states for all OMAP platforms that don't
> populate DT. This allows drivers to be converted to pinctrl
> and not generate new warnings on platforms that do not provide
> pinctrl data. These platforms already have pinmuxes configured
> before the drivers probe.
>
> Signed-off-by: Matt Porter <mporter@ti.com>

Looks like a good idea, so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
