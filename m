From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jun 2016 23:01:06 -0700
Subject: [GIT PULL] omap-gpmc fixes for v4.7 rc cycle
In-Reply-To: <57626DF2.70907@ti.com>
References: <57626DF2.70907@ti.com>
Message-ID: <20160619060106.GB16376@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 12:14:26PM +0300, Roger Quadros wrote:
> Hi Arnd/Olof,
> 
> The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:
> 
>   Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git tags/gpmc-omap-fixes-for-v4.7
> 
> for you to fetch changes up to 8f50b8e57442d28e41bb736c173d8a2490549a82:
> 
>   memory: omap-gpmc: Fix omap gpmc EXTRADELAY timing (2016-06-16 11:43:48 +0300)
> 
> ----------------------------------------------------------------
> OMAP-GPMC: Fixes for for v4.7-rc cycle:
> 
> - Fix omap gpmc EXTRADELAY timing. The DT provided timings
> were wrongly used causing devices requiring extra delay timing
> to fail.

So, our fixes branch is at 4.7-rc1, so now you force us to bring in -rc3 just
because of this one patch. That's a little annoying. Base your branch on an
older release if it makes sense, and/or take a look at what release our
branch is on if you think of it. :)

It's not a huge deal but the main disadvantage is that git request-pull
sometimes gets confused of what's actually in the branch and not, so it might
produce an incorrect pull request. We normally don't have to deal with that on
fixes, only what we stage for the merge windows.

Anyhow, I've merged this for now.


-Olof
