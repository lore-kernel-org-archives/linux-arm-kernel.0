From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 24 Apr 2013 10:56:35 +0800
Subject: [PATCH 07/21] ARM: tegra: unify tegra_idle_device definitions
In-Reply-To: <5177055D.1060307@linaro.org>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-8-git-send-email-arnd@arndb.de>
 <5176BD29.1000405@linaro.org> <201304232057.37055.arnd@arndb.de>
 <5177055D.1060307@linaro.org>
Message-ID: <1366772195.18275.3.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-24 at 06:04 +0800, Daniel Lezcano wrote:
> On 04/23/2013 08:57 PM, Arnd Bergmann wrote:
> > On Tuesday 23 April 2013, Daniel Lezcano wrote:
> >> the patch sounds good but I think the side effect of the consolidation
> >> patchset [1] fixed that.
> >>
> >> You can find these fixes in Rafael's tree:
> >>
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&amp;id=4c637b2175a0dc65d533494225525c6c82d73293
> >>
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&amp;id=e158f9da6974cc11bfab2246a9b10021af0e0d8a
> >>
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&amp;id=c5106c9dea9a6022ab84c6cb1d4a0b19fc5af0e2
> >>
> >> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&amp;id=f040c26ffaa5e56f2bca427c719c9601a02e70e5
> >>
> >> [1] http://www.spinics.net/lists/arm-kernel/msg239811.html
> >>
> > 
> > Ah. Is that not in linux-next? I created the patch today based on the latest
> > linux-next from today (Tuesday).
> 
> Ah, ok. Actually the patches were taken by Rafael right today. So it is
> possible the changes were not reflected in linux-next yet.
> 
Hi Arnd and Daniel,

Thanks for taking care this.:)

Joseph
