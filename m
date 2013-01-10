From: airlied@gmail.com (Dave Airlie)
Date: Thu, 10 Jan 2013 10:16:10 +1000
Subject: [RFC 0/4] TI LCDC DRM driver
In-Reply-To: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
References: <1357704685-3600-1-git-send-email-robdclark@gmail.com>
Message-ID: <CAPM=9tzZiQuVNdNhm9=iNWqAwk+uZRh0_YC3QLkyZbne5dfeyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 9, 2013 at 2:11 PM, Rob Clark <robdclark@gmail.com> wrote:
> Updated version of DRM driver for TI LCD Controller.  Since the initial
> version of the patch, which only supported TFP410 DVI output, I've added
> an output driver for LCD panels (for example, LCD3 or LCD7 cape for the
> beagle-bone), and initial support for HDMI output via NXP TDA19988 HDMI
> encoder (via i2c encoder-slave output driver).
>
> At this point, I think the basic lcdc drm driver plus TFP410 DVI output
> (first patch) is in reasonable shape (barring potential rename, if lcdc
> is too generic of a name... but I was not feeling creative enough yet to
> pick a new name).

I'd like at least tilcdc :-)

Dave.
