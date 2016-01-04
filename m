From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jan 2016 09:39:46 +0100
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <20160104082416.GB23797@ulmo>
References: <4194408.X82ccDjh5X@wuerfel> <5213510.IMdSbsXdoQ@wuerfel>
 <20160104082416.GB23797@ulmo>
Message-ID: <4350671.DP0mBIml5S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 09:24:16 Thierry Reding wrote:
> 
> Ugh... wouldn't it be much simpler to get rid of DRM_ARM? It seems like
> a completely superfluous option to me. I don't think we've ever had the
> equivalent of "vendor" Kconfig options in DRM, and I don't see why we'd
> need to start now. If ARM was going to add another driver it can simply
> have a separate Kconfig entry. There should be no need to select the
> vendor option first.

Fine with me too. I vaguely remembered having seen some discussion about
this, so I decided to do a minimal fix, but I agree that would be more
in line with the other drivers.

	Arnd
