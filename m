From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Apr 2013 19:31:00 -0400 (EDT)
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <20130424202526.GB14496@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <20130423200429.GF5316@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231657150.17375@syhkavp.arg>
 <20130423214610.GY14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231755370.17375@syhkavp.arg>
 <20130423224441.GZ14496@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304232327120.17375@syhkavp.arg>
 <20130424202526.GB14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304241927340.1258@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Apr 2013, Russell King - ARM Linux wrote:

> On Wed, Apr 24, 2013 at 12:11:26AM -0400, Nicolas Pitre wrote:
> > The latest MCPM patches are available here:
> > 
> >   git://git.linaro.org/people/nico/linux mcpm
> > 
> > Diffstat:
> > 
> >  Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
> >  Documentation/arm/vlocks.txt                    | 211 ++++++++
> >  arch/arm/Kconfig                                |   8 +
> >  arch/arm/common/Makefile                        |   1 +
> >  arch/arm/common/mcpm_entry.c                    | 263 +++++++++
> >  arch/arm/common/mcpm_head.S                     | 219 ++++++++
> >  arch/arm/common/mcpm_platsmp.c                  |  92 ++++
> >  arch/arm/common/vlock.S                         | 108 ++++
> >  arch/arm/common/vlock.h                         |  29 +
> >  arch/arm/include/asm/cacheflush.h               |  75 +++
> >  arch/arm/include/asm/mcpm.h                     | 209 ++++++++
> >  arch/arm/kernel/asm-offsets.c                   |   4 +
> >  12 files changed, 1717 insertions(+)
> > 
> > The corresponding DCSCB support for RTSM is here:
> > 
> >   git://git.linaro.org/people/nico/linux mcpm+dcscb
> > 
> > although that part is probably more suitable for ARM-SOC.
> > 
> > Do you want those patches to be posted again, or should I send a new 
> > pull request?
> 
> I've been doing some further digging in these patches this evening, via
> https://git.linaro.org/gitweb?p=people/nico/linux.git;a=shortlog;h=refs/heads/mcpm
> 
> I think they're now in pretty good shape and are ready to be pulled.

Great!  Please feel free to pull the mcpm branch.  I've nothing to add 
to it.


Nicolas
