From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Sep 2011 16:52:54 -0700
Subject: [PATCH 5/5] omap2plus_defconfig: Enable omap3isp and MT9T111
	sensor drivers
In-Reply-To: <201109210113.49151.laurent.pinchart@ideasonboard.com>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
	<1316530612-23075-6-git-send-email-deepthy.ravi@ti.com>
	<201109210113.49151.laurent.pinchart@ideasonboard.com>
Message-ID: <20110920235254.GM2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110920 15:40]:
> >  CONFIG_REGULATOR_TPS65023=y
> >  CONFIG_REGULATOR_TPS6507X=y
> > +CONFIG_MEDIA_SUPPORT=y
> > +CONFIG_MEDIA_CONTROLLER=y
> > +CONFIG_VIDEO_DEV=y
> > +CONFIG_VIDEO_V4L2_COMMON=y
> > +CONFIG_VIDEO_ALLOW_V4L1=y
> > +CONFIG_VIDEO_V4L1_COMPAT=y
> > +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> > +CONFIG_VIDEO_MEDIA=y
> > +CONFIG_VIDEO_MT9T111=y
> > +CONFIG_VIDEO_OMAP3=y
> 
> Shouldn't they be compiled as modules instead ?

Yes, let's not apply this.

Tony
