From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 13:18:55 +0100
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <20160111111255.GE13633@e106497-lin.cambridge.arm.com>
References: <4194408.X82ccDjh5X@wuerfel> <4350671.DP0mBIml5S@wuerfel>
 <20160111111255.GE13633@e106497-lin.cambridge.arm.com>
Message-ID: <10589993.Lxk3kTHnpj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 11:12:56 Liviu Dudau wrote:
> On Mon, Jan 04, 2016 at 09:39:46AM +0100, Arnd Bergmann wrote:
> > On Monday 04 January 2016 09:24:16 Thierry Reding wrote:
> > > 
> > > Ugh... wouldn't it be much simpler to get rid of DRM_ARM? It seems like
> > > a completely superfluous option to me. I don't think we've ever had the
> > > equivalent of "vendor" Kconfig options in DRM, and I don't see why we'd
> > > need to start now. If ARM was going to add another driver it can simply
> > > have a separate Kconfig entry. There should be no need to select the
> > > vendor option first.
> > 
> > Fine with me too. I vaguely remembered having seen some discussion about
> > this, so I decided to do a minimal fix, but I agree that would be more
> > in line with the other drivers.
> > 
> >       Arnd
> > 
> 
> Arnd,
> 
> I'm OK with the whole series of Kconfig clean-up/fixes and I offer my appologies
> for adding noise with my patchset. Please let me know how do you prefer to handle
> them. I'm OK with merging your changes into my series before sending the pull
> request to David Airlie.

Please merge them into your tree if you have some other changes to send to him.

I just realized that these are in your own git tree at the moment, not
in drm-next. I guess that means you will rebase the whole series after -rc1 and
submit it into linux-4.6, right?

If so, just fold my fixes into your patches when you rebase.

	Arnd
