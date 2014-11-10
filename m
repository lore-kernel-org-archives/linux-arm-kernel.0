From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Nov 2014 12:34:52 -0800
Subject: [PATCH V2 3/3] ARM: dts: dra72-evm: Add MMC nodes
In-Reply-To: <1413902156-32684-1-git-send-email-nm@ti.com>
References: <1413901848-32268-1-git-send-email-nm@ti.com>
 <1413902156-32684-1-git-send-email-nm@ti.com>
Message-ID: <20141110203451.GU31454@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [141021 07:37]:
> Add MMC1 and 2 nodes. MMC1 is SDcard and MMC2 is eMMC.
> 
> NOTE on MMC1 card detect: Ideally, we should be using in-built SDCD
> support, but we dont have it yet. So, use the fact that control module
> of DRA7 is setup such that no matter what mode one configures it, GPIO
> option is always hardwired in - use GPIO mode for SDcard detection.
> 
> [peter.ujfalusi at ti.com]
> The power line feeding the SD card is also used by other devices on the EVM.
> Use generic name instead of mmc2_3v3 so when other devices want to use the
> same regulator it will look a bit better.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> 
> Apologies on the spam, I got my own name screwed up -fixing that right now

Applying all three into omap-for-v3.19/dt thanks.

Tony
 
> Changes in V2: Fixes the formatting error in author name.
> V1: https://patchwork.kernel.org/patch/5125291/
