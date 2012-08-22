From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 22 Aug 2012 09:26:36 +0000
Subject: [PATCH 5/5] ASoC: tlv320aic3x: Add device tree bindings
In-Reply-To: <20120817224512.GL18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-6-git-send-email-gururaja.hebbar@ti.com>
 <20120817224512.GL18871@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA64BA4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 18, 2012 at 04:15:13, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 06:12:05PM +0530, Hebbar, Gururaja wrote:
> 
> > +- gpio-reset - <int> -  gpio pin number used for codec reset
> 
> This should be a standard DT GPIO reference by phandle like:
> 
> 	gpio = <&gpio1 16 0>;

I will correct in V2

> 
> There's quite a few examples in tree.
> 
> Otherwise this looks good.
> 

Thanks for all the reviews.

Regards, 
Gururaja
