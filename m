From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2012 10:53:17 +0200
Subject: [CFT 02/11] mmc: omap_hsmmc: add DMA engine support
In-Reply-To: <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaq5AYZapS-YSTXa4atJQESiqKvmpnXBYE_aOD4+PkigQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 1:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP HSMMC driver. ?This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
