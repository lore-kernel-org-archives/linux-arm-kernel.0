From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Aug 2014 21:05:17 -0700
Subject: [PATCH 13/14] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC)
 support
In-Reply-To: <20140827145021.GC13850@arm.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-5-git-send-email-ch.naveen@samsung.com>
 <20140827110927.GC7773@leverpostej>
 <20140827145021.GC13850@arm.com>
Message-ID: <20140828040517.GF4972@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 03:50:21PM +0100, Catalin Marinas wrote:
> On Wed, Aug 27, 2014 at 12:09:28PM +0100, Mark Rutland wrote:
> > On Wed, Aug 27, 2014 at 10:44:20AM +0100, Naveen Krishna Chatradhi wrote:
> > > +	select HAVE_SMP
> > 
> > I may have missed something, but I didn't see any SMP support in this
> > series.
> 
> We don't even have HAVE_SMP defined for arm64 (just SMP, which is on in
> defconfig).
> 
> In theory we don't need any specific SMP support for a new SoC as long
> as it uses a standard booting protocol (e.g. PSCI). But for whatever
> reason, I only received about four patches in this series, so can't see
> the rest.

Seems like about 9 of them made it to the list for me.


-Olof
