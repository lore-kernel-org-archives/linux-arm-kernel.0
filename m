From: liviu.dudau@arm.com (Liviu Dudau)
Date: Mon, 11 Jan 2016 14:14:00 +0000
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <25171013.5skSCnRsN9@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel> <10589993.Lxk3kTHnpj@wuerfel>
 <20160111122644.GH13633@e106497-lin.cambridge.arm.com>
 <25171013.5skSCnRsN9@wuerfel>
Message-ID: <20160111141400.GJ13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2016 at 02:49:10PM +0100, Arnd Bergmann wrote:
> On Monday 11 January 2016 12:26:44 Liviu Dudau wrote:
> > > If so, just fold my fixes into your patches when you rebase.
> > 
> > OK, will do. Repeating the question on another thread: are you OK with me carrying
> > the Juno .dts changes through drm-next for HDLCD and you picking up Robin Murphy's
> > patch? AFAIK those are the only changes at the moment until Sudeep re-submits the
> > Juno r2 dts changes.
> 
> Is there a strong reason for it? Usually the preferred way is to merge all
> dts changes through arm-soc, but we can make exceptions if necessary.

No strong reason, just packing the series in a logical way. I'm happy to split the
pull requests. Will send the dts changes to you then.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
