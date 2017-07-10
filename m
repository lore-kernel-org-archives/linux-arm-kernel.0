From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 10 Jul 2017 08:31:07 +0200
Subject: [PATCH] ASoC: pxa: SND_PXA2XX_SOC should depend on HAS_DMA
In-Reply-To: <1499628632-15421-1-git-send-email-geert@linux-m68k.org> (Geert
 Uytterhoeven's message of "Sun, 9 Jul 2017 21:30:32 +0200")
References: <1499628632-15421-1-git-send-email-geert@linux-m68k.org>
Message-ID: <87ziccst04.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> If NO_DMA=y:
>
>     ERROR: "bad_dma_ops" [sound/soc/pxa/snd-soc-pxa2xx.ko] undefined!
>     ERROR: "bad_dma_ops" [sound/arm/snd-pxa2xx-lib.ko] undefined!
>     ERROR: "dma_common_mmap" [sound/arm/snd-pxa2xx-lib.ko] undefined!
>
> Add a dependency on HAS_DMA to fix this.
>
> Fixes: 73d7ee2e831f106c ("ASoC: pxa: add COMPILE_TEST on SND_PXA2XX_SOC")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
