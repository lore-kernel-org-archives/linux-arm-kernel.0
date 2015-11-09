From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 09 Nov 2015 20:49:18 +0100
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <20151109120720.GF963@e106497-lin.cambridge.arm.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <20151109120334.GZ8644@n2100.arm.linux.org.uk>
 <20151109120720.GF963@e106497-lin.cambridge.arm.com>
Message-ID: <2772927.crXiDc9cOV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

Am Montag, 9. November 2015, 12:07:20 schrieb Liviu Dudau:
> On Mon, Nov 09, 2015 at 12:03:35PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 09, 2015 at 11:57:27AM +0000, Liviu Dudau wrote:
> > > Meanwhile, what is your suggestion regarding the patchset. I've seen David has
> > > sent Linus a pull request for 4.4-rc1 that includes it. Should we send a
> > > revert for rockchip commit and then patch later the function?
> > 
> > It definitely needs to be fixed, and I'd suggest its early enough in the
> > -rc cycle (which hasn't begun yet) to simply fix drm_of_component_probe()
> > to take two compare functions.
> 
> I still don't have a Rockchip board to test the patch, so I need to find out
> someone willing to test them. Mark?

I of course also have a plethora of rockchip boards, so can test stuff
as well.


Heiko
