From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Sep 2011 07:10:35 -0600 (MDT)
Subject: [PATCH 6/6] OMAP2+: id: remove OMAP_REVBITS_* macros
In-Reply-To: <4E70A337.6090400@compulab.co.il>
References: <20110913212638.26161.62284.stgit@dusk>
	<20110913212806.26161.37867.stgit@dusk>
	<4E709D13.1080908@compulab.co.il>
	<alpine.DEB.2.00.1109140628520.27954@utopia.booyaka.com>
	<4E70A337.6090400@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1109140708590.27954@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Wed, 14 Sep 2011, Igor Grinberg wrote:

> I've applied those manually on top of v3.1-rc3:
> 
> --------------cut--------------------
> [    0.000000] Linux version 3.1.0-rc3-00006-ga942f6de (grinberg at grinberg-linux) (gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) ) #1 SMP Wed Sep 14 15:35:32 IDT 2011
> [    0.000000] CPU: ARMv7 Processor [411fc087] revision 7 (ARMv7), cr=10c53c7f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] Machine: Compulab CM-T3517
> [    0.000000] Reserving 8388608 bytes SDRAM for VRAM
> [    0.000000] Memory policy: ECC disabled, Data cache writeback
> [    0.000000] OMAP3430/3530 ES1.0 (l2cache iva sgx neon isp )
> ----------cut----------------------------
>                ^^^^^^^^^^^^^^^^^^^
> 
> While U-Boot says:
> 
> ------------cut---------------------
> U-Boot 2009.11-cm-t3517-1 (Dec 10 2010 - 23:25:02)
> 
> AM35xx-GP ES1.0, L3-165MHz
> ------------cut---------------------
> 
> Do I miss something, that should be in your tree?
> Pulling it in right now, should be available shortly...

Could you try this patch on top of the ones that you are testing?

thanks for the testing help,


- Paul
