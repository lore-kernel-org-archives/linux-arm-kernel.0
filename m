From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 08 Jan 2010 17:30:06 -0700
Subject: [PATCH] iop: use generic clock mult/shift compute functions
In-Reply-To: <20100108172654.GK32558@n2100.arm.linux.org.uk>
References: <19258.8113.311122.46281@pilspetsen.it.uu.se>
	<20100108172654.GK32558@n2100.arm.linux.org.uk>
Message-ID: <1262997006.20537.5.camel@dwillia2-linux.ch.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-08 at 10:26 -0700, Russell King - ARM Linux wrote:
> On Tue, Dec 29, 2009 at 04:26:41PM +0100, Mikael Pettersson wrote:
> > The 2.6.33-rc kernel now has generic functions for computing
> > mult and shift factors for clocksources and clockevents. Thus
> > we can remove the equivalent private code from the ARM IOP
> > platform and use the generic code instead.
> > 
> > Tested on an n2100 iop32x machine. Verfied to result in the
> > exact same mult and shift factors as before.
> 
> Good, can we have it in the patch system please?

It's pushed out to the 'fixes' branch of xscaleiop.git.  Please pull
from:

git://git.kernel.org/pub/scm/linux/kernel/git/djbw/xscaleiop.git fixes

I was going to check it out on my iop13xx, but the board is occupied and
I doubt it will cause problems given the other testing.

--
Dan
