From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 9 Nov 2015 12:07:20 +0000
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <20151109120334.GZ8644@n2100.arm.linux.org.uk>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
 <564069CD.2070102@rock-chips.com>
 <20151109114259.GX8644@n2100.arm.linux.org.uk>
 <20151109115727.GE963@e106497-lin.cambridge.arm.com>
 <20151109120334.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <20151109120720.GF963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 12:03:35PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 09, 2015 at 11:57:27AM +0000, Liviu Dudau wrote:
> > Meanwhile, what is your suggestion regarding the patchset. I've seen David has
> > sent Linus a pull request for 4.4-rc1 that includes it. Should we send a
> > revert for rockchip commit and then patch later the function?
> 
> It definitely needs to be fixed, and I'd suggest its early enough in the
> -rc cycle (which hasn't begun yet) to simply fix drm_of_component_probe()
> to take two compare functions.

I still don't have a Rockchip board to test the patch, so I need to find out
someone willing to test them. Mark?

> 
> I'd also suggest at this point another change: please rename it to
> drm_of_kms_component_probe() since this is only a generic case for KMS
> drivers.  GPU DRM drivers need something different.

OK, will do.

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
