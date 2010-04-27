From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Tue, 27 Apr 2010 22:07:37 +0200
Subject: [PATCH] DMAENGINE: DMA40 U8500 platform configuration v4
In-Reply-To: <1272395344-744-1-git-send-email-linus.walleij@stericsson.com>
References: <1272395344-744-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025A4964A5@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Self]

> This completes the DMA40 support with the platform-specific
> configuration for U8500/DB8500.
(...)
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -137,7 +137,7 @@ static void __init u8500_init_machine(void)
>  	u8500_init_devices();
>  }
> 
> -MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
> +MACHINE_START(NOMADIK, "ST-Ericsson MOP500 platform")

Oh no, I shouldn't touch that. Will fix this...

Yours,
Linus Walleij
