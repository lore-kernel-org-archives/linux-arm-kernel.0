From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2012 10:52:11 +0200
Subject: [CFT 04/11] mmc: omap: add DMA engine support
In-Reply-To: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYVSuH_hFcwkqo-i6-aTZrmFx5GP80RC8b3xdu=SWHeEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 7, 2012 at 1:07 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP driver. ?This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This looks good as well:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
