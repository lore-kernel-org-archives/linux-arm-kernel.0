From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 22 Dec 2015 17:30:09 +0000
Subject: [PATCH v4 0/4] drm: Add support for the ARM HDLCD display
 controller
In-Reply-To: <20151203165606.GS8644@n2100.arm.linux.org.uk>
References: <1449139249-9171-1-git-send-email-Liviu.Dudau@arm.com>
 <20151203165606.GS8644@n2100.arm.linux.org.uk>
Message-ID: <20151222173009.GT960@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 04:56:07PM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 03, 2015 at 10:40:45AM +0000, Liviu Dudau wrote:
> > This series depends on Sudeep Holla's SCPI driver (now in mainline) and on
> > the tda998x patches that have been queued on Russell's patch system here [1].
> 
> Now merged into my tree.

Hi Russell,

Can I ask about the faith of the patches that I have queued here:

http://www.arm.linux.org.uk/developer/patches/search.php?uid=2895

I can't find them in any of your public git branches (or I failed at git 101).

Best regards,
Liviu

> 
> Can I ask a fairly obvious question...
> 
> >  drivers/gpu/drm/Kconfig                            |   2 +
> >  drivers/gpu/drm/Makefile                           |   1 +
> >  drivers/gpu/drm/arm/Kconfig                        |  29 ++
> >  drivers/gpu/drm/arm/Makefile                       |   2 +
> >  drivers/gpu/drm/arm/hdlcd_crtc.c                   | 327 ++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.c                    | 555 +++++++++++++++++++++
> >  drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
> >  drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
> 
> Why is the subdirectory called "arm" and not "hdlcd" ?
> 
> ARM Ltd have more than one display controller (they have the AMBA PL110
> and PL111 in addition to this), and (afaics) this doesn't drive these.
> HDLCD probably won't be the last display hardware which ARM Ltd comes
> out with either.
> 
> So, I think naming the subdirectory after the vendor is probably a
> mistake.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
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
