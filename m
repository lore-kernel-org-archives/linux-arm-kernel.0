From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 15 Aug 2013 22:18:08 +0300
Subject: [PATCH 0/2] ARM: OMAP: fix USB regression on Nokia boards
In-Reply-To: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
References: <1375808776-14975-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20130815191808.GA3067@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 06, 2013 at 08:06:14PM +0300, Aaro Koskinen wrote:
> USB subsystem changes broke the USB peripheral/gadget on N800, N810 and
> RX-51/N900 during the merge window. We need to fix this in board files. I
> tested all these with 3.11-rc4 + g_ether + ssh.

Ping?

A.

> Aaro Koskinen (1):
>   ARM: OMAP: rx51: change musb mode to OTG
> 
> Daniel Mack (1):
>   ARM: omap2: fix musb usage for n8x0
> 
>  arch/arm/mach-omap2/board-n8x0.c | 4 ----
>  arch/arm/mach-omap2/board-rx51.c | 2 +-
>  arch/arm/mach-omap2/usb-musb.c   | 5 +----
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
