From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 10:36:48 -0700
Subject: [GIT PULL] soc: Keystone SOC Navigator drivers for 3.18
In-Reply-To: <5422CDB1.9060505@ti.com>
References: <1409865234-9932-1-git-send-email-santosh.shilimkar@ti.com>
 <20140924044317.GB24803@localhost> <5422CDB1.9060505@ti.com>
Message-ID: <20140924173648.GA19284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 09:57:05AM -0400, Santosh Shilimkar wrote:
> On Wednesday 24 September 2014 12:43 AM, Olof Johansson wrote:
> > On Thu, Sep 04, 2014 at 05:13:54PM -0400, Santosh Shilimkar wrote:
> >> Hi Arm-soc folks,
> >>
> >> Please pull below Keystone SOC drivers. They have been on the list for review
> >> for last few merge windows. I got handful of comments on DTS bindings which
> >> has been already addressed. This should ungate me to get network support for
> >> Keystone which is missing in mainline.
> >>
> >> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> >>
> >>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers-soc-ti
> >>
> >> for you to fetch changes up to e9e7494bdcc7926237823253707691d0f3787be2:
> >>
> >>   MAINTAINERS: Add Keystone Multicore Navigator drivers entry (2014-09-04 16:40:16 -0400)
> >>
> >> ----------------------------------------------------------------
> >> Keystone SOC Navigator drivers for 3.18
> >>
> >> The Keystone Multi-core Navigator contains QMSS and packet DMA
> >> subsystems which interwork together to form the Navigator cloud
> >> used by various subsystems like NetCP, SRIO, SideBand Crypto
> >> engines etc.
> >>
> >> ----------------------------------------------------------------
> >> Sandeep Nair (3):
> >>       firmware: add Keystone QMSS PDSP accumulator firmware blob
> >>       Documentation: dt: soc: add Keystone Navigator QMSS bindings
> >>       soc: ti: add Keystone Navigator QMSS driver
> >>
> >> Santosh Shilimkar (3):
> >>       Documentation: dt: soc: add Keystone Navigator DMA bindings
> >>       soc: ti: add Keystone Navigator DMA support
> >>       MAINTAINERS: Add Keystone Multicore Navigator drivers entry
> > 
> > Hi Santosh,
> > 
> > I was going through the queue of merges to do and it seems like Arnd
> > missed this one.
> > 
> > Before I merge it though -- it looks like the firmware should be added to
> > the linux-firmware repository instead? We try to avoid adding new firmware
> > files in the kernel tree these days and get them from there instead...
> > 
> Right. Typically firmware files in kernel are not encoraged. This is infrastructure
> driver so the firmware is needed for it to work. I will try to get that
> patch via linux-firmware tree.
> 
> > Can you respin with that fixed, or should I cherry-pick the contents from
> > this branch instead (all but that patch)?
> > 
> Just refreshed the branch and updated the new tag. 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
> tags/drivers-soc-ti-v2
> 
> Can you please pull that one ?

Done, merged.


-Olof
