From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 23 Aug 2012 05:13:59 +0000
Subject: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree bindings
In-Reply-To: <20120822155808.GP7995@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
 <20120817223122.GA21445@opensource.wolfsonmicro.com>
 <1BAFE6F6C881BF42822005164F1491C33EA67DA1@DBDE01.ent.ti.com>
 <20120822155808.GP7995@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA68662@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 21:28:08, Mark Brown wrote:
> On Wed, Aug 22, 2012 at 01:50:09PM +0000, Hebbar, Gururaja wrote:
> 
> > From your for-3.7 branch, I could only find such implementation in Tegra
> > Platform. 
> > Most Freescale platforms implements this through a device/driver method.
> > Exception being sound/soc/mxs/mxs-pcm.c
> 
> > So should I follow tegra implementation?
> 
> Tegra and mxs should be good examples, yes.

Ok. Will update in V2

> 


Regards, 
Gururaja
