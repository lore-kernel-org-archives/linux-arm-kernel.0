From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 16:33:22 +0200
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <5714857C.9070002@intel.com>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <6297512.2KmasKu6UN@wuerfel> <5714857C.9070002@intel.com>
Message-ID: <7893683.FFM02uuNdT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 09:58:04 Adrian Hunter wrote:
> 
> Thanks for looking.
> 
> It looked to me like sdhci-pxav3 devices created by mmp2_add_sdhost() might
> also be candidates.
> 

Oh, you are right, I missed that.

I remember looking at sdhci-pxav2 and not finding any machine defining one,
but I must have skipped over sdhci-pxav3 failing to realize that this is
a different one.

	Arnd
