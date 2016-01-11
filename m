From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 14:49:10 +0100
Subject: [PATCH 4/3] drm: arm-hdlcd: add explictit DRM dependency
In-Reply-To: <20160111122644.GH13633@e106497-lin.cambridge.arm.com>
References: <4194408.X82ccDjh5X@wuerfel> <10589993.Lxk3kTHnpj@wuerfel>
 <20160111122644.GH13633@e106497-lin.cambridge.arm.com>
Message-ID: <25171013.5skSCnRsN9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 12:26:44 Liviu Dudau wrote:
> > If so, just fold my fixes into your patches when you rebase.
> 
> OK, will do. Repeating the question on another thread: are you OK with me carrying
> the Juno .dts changes through drm-next for HDLCD and you picking up Robin Murphy's
> patch? AFAIK those are the only changes at the moment until Sudeep re-submits the
> Juno r2 dts changes.

Is there a strong reason for it? Usually the preferred way is to merge all
dts changes through arm-soc, but we can make exceptions if necessary.

	Arnd
