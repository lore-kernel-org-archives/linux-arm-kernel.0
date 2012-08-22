From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 22 Aug 2012 13:50:09 +0000
Subject: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree bindings
In-Reply-To: <20120817223122.GA21445@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
 <20120817223122.GA21445@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 04:01:24, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:03PM +0530, Hebbar, Gururaja wrote:
> > Device tree support for Davinci/OMAP2+ pcm driver.
> 
> This looks like it's a device which maps a shared DMA controller in the
> SoC core into ASoC rather than actual hardware.  Such devices are
> usually instantiated automatically from the DAI rather than being
> represented in the device tree since they are a Linux internal thing
> really - the Tegra and Freescale drivers provide examples of how this
> sort of thing can be done.

>From your for-3.7 branch, I could only find such implementation in Tegra
Platform. 
Most Freescale platforms implements this through a device/driver method.
Exception being sound/soc/mxs/mxs-pcm.c

So should I follow tegra implementation?
> 


Regards, 
Gururaja
