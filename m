From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Sat, 21 Dec 2013 13:51:45 +0530
Subject: [PATCH v2 2/2] gpio: davinci: reuse for Keystone SoC
In-Reply-To: <1387361272-20861-3-git-send-email-grygorii.strashko@ti.com>
References: <1387361272-20861-1-git-send-email-grygorii.strashko@ti.com>
 <1387361272-20861-3-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CA+V-a8vChjoYhtmGVkARxtX=dTrDAsbS5L1o69jN2pSg0v13xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 3:37 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> The similar GPIO HW block is used by keystone SoCs as
> in Davinci SoCs.
> Hence, reuse Davinci GPIO driver for Keystone taking into
> account that Keystone contains ARM GIC IRQ controller which
> is implemented using IRQ Chip.
>
> Documentation:
>         http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: devicetree at vger.kernel.org
>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Regards,
--Prabhakar Lad
