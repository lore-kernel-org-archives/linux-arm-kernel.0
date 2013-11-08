From: marex@denx.de (Marek Vasut)
Date: Fri, 8 Nov 2013 02:43:33 +0100
Subject: [PATCH] ARM: pxa/colibri: fix build with CONFIG_USB_OHCI_HCD=y
In-Reply-To: <1383835013-22215-1-git-send-email-mad_soft@inbox.lv>
References: <1383835013-22215-1-git-send-email-mad_soft@inbox.lv>
Message-ID: <201311080243.33269.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dmitry Artamonow,

> Fix following build failure observed when support for
> OHCI host controller is enabled.
> 
>   CC      arch/arm/mach-pxa/colibri-evalboard.o
> arch/arm/mach-pxa/colibri-evalboard.c: In function 'colibri_ohci_init':
> arch/arm/mach-pxa/colibri-evalboard.c:68: error: implicit declaration of
> function 'IOMEM' make[1]: *** [arch/arm/mach-pxa/colibri-evalboard.o]
> Error 1
> make: *** [arch/arm/mach-pxa] Error 2
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.lv>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
