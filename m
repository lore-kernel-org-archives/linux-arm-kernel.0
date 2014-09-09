From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Sep 2014 11:50:21 +0900
Subject: [PATCH 0/5] ARM: shmobile: Use SoC-specific clock source compat
 strings
In-Reply-To: <20140908002956.GA32532@verge.net.au>
References: <1410136068-32220-1-git-send-email-horms+renesas@verge.net.au>
 <20140908002956.GA32532@verge.net.au>
Message-ID: <20140909025021.GF31320@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 09:29:56AM +0900, Simon Horman wrote:
> On Mon, Sep 08, 2014 at 09:27:43AM +0900, Simon Horman wrote:
> > In general Renesas hardware is not documented to the extent
> > where the relationship between IP blocks on different SoCs can be assumed
> > although they may appear to operate the same way. Furthermore the
> > documentation typically does not specify a version for individual
> > IP blocks. For these reasons a convention of using the SoC name in place
> > of a version and providing SoC-specific compat strings has been adopted.
> > 
> > Although not universally liked this convention is used in the bindings
> > for a number of drivers for Renesas hardware. The purpose of this series
> > is to make use of SoC specific clock source strings.
> 
> This series is based on
> renesas-next-20140904v2-v3.17-rc2
> 
> The bindings used are proposed in
> "[PATCH v3 0/3] clocksource: Document Renesas SoC specific bindings"
> 
> > Simon Horman (5):
> >   ARM: shmobile: r8a7740: Use SoC-specific 48-bit CMT compat string
> >   ARM: shmobile: r8a7790: Use SoC-specific 48-bit CMT compat string
> >   ARM: shmobile: r8a7791: Use SoC-specific 48-bit CMT compat string
> >   ARM: shmobile: r7s72100: Use SoC-specific MTU2 compat string
> >   ARM: shmobile: r8a7779: Use SoC-specific TMU compat string
> > 
> >  arch/arm/boot/dts/r7s72100.dtsi | 2 +-
> >  arch/arm/boot/dts/r8a7740.dtsi  | 2 +-
> >  arch/arm/boot/dts/r8a7779.dtsi  | 6 +++---
> >  arch/arm/boot/dts/r8a7790.dtsi  | 4 ++--
> >  arch/arm/boot/dts/r8a7791.dtsi  | 4 ++--
> >  5 files changed, 9 insertions(+), 9 deletions(-)

I have queued up these changes.
