From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jan 2016 11:12:56 +0000
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <4350671.DP0mBIml5S@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel> <5213510.IMdSbsXdoQ@wuerfel>
 <20160104082416.GB23797@ulmo> <4350671.DP0mBIml5S@wuerfel>
Message-ID: <20160111111255.GE13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 09:39:46AM +0100, Arnd Bergmann wrote:
> On Monday 04 January 2016 09:24:16 Thierry Reding wrote:
> > 
> > Ugh... wouldn't it be much simpler to get rid of DRM_ARM? It seems like
> > a completely superfluous option to me. I don't think we've ever had the
> > equivalent of "vendor" Kconfig options in DRM, and I don't see why we'd
> > need to start now. If ARM was going to add another driver it can simply
> > have a separate Kconfig entry. There should be no need to select the
> > vendor option first.
> 
> Fine with me too. I vaguely remembered having seen some discussion about
> this, so I decided to do a minimal fix, but I agree that would be more
> in line with the other drivers.
> 
> 	Arnd
> 

Arnd,

I'm OK with the whole series of Kconfig clean-up/fixes and I offer my appologies
for adding noise with my patchset. Please let me know how do you prefer to handle
them. I'm OK with merging your changes into my series before sending the pull
request to David Airlie.

Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
