From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:09:25 -0700
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add DT node for TI PCA9536
In-Reply-To: <CACRpkdbRt4Vi=kzs_gZDkR14KBmFsKKZawbT25PW0sMpuX7LkQ@mail.gmail.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
 <1463640450-16762-3-git-send-email-vigneshr@ti.com>
 <CACRpkdbRt4Vi=kzs_gZDkR14KBmFsKKZawbT25PW0sMpuX7LkQ@mail.gmail.com>
Message-ID: <20160610110925.GY22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [160526 01:42]:
> On Thu, May 19, 2016 at 8:47 AM, Vignesh R <vigneshr@ti.com> wrote:
> 
> > AM335x ICE board has a TI PCA9536 chip connected to I2C0 at address
> > 0x41. Add DT entry for the same.
> >
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Pls take this through the ARM SoC TI git tree.

Applying this patch into omap-for-v4.8/dt thanks.

Tony
