From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Dec 2010 15:21:57 +0000
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTik5NaF3r3mocthuVc-NiYNS3yJbEpkNt3_ghjUj@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
	<20101203165105.GD30898@n2100.arm.linux.org.uk>
	<AANLkTik9sqkbCPbcWUL+2otyfO1OZ=hx1tvSkQW65e4i@mail.gmail.com>
	<4CFBAC6D.5060507@codesourcery.com>
	<AANLkTi=woxGqfpd12tr32FymOx77UnVehvEFQt5GnRzG@mail.gmail.com>
	<4CFD87A6.8030104@codesourcery.com>
	<AANLkTikh-a++NQj+cUJOf9B3tjr_=CvAqJmjhLGA0Xt7@mail.gmail.com>
	<20101207110401.GA20451@n2100.arm.linux.org.uk>
	<AANLkTik5NaF3r3mocthuVc-NiYNS3yJbEpkNt3_ghjUj@mail.gmail.com>
Message-ID: <20101207152157.GC23589@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 03:06:51PM +0000, Dave Martin wrote:
> Hi,
> 
> On Tue, Dec 7, 2010 at 11:04 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Dec 07, 2010 at 10:45:42AM +0000, Dave Martin wrote:
> >> Yes-- though I didn't elaborate on it. ?You need a packager that can
> >> understand, say, that a binary built for ARMv5 EABI can interoperate
> >> with ARMv7 binaries etc.
> >> Again, I've heard it suggested that RPM can handle this, but I haven't
> >> looked at it in detail myself.
> >
> > That is indeed the case - as on x86, it used to be common to build the
> > majority of the distribution for i386, and glibc and a few other bits
> > for a range of ix86 CPUs.
> >
> > rpm and yum know that i386 is compatible with i486, which is compatible
> > with i586 etc, so it will install an i386 package on i686 if no i486,
> > i586 or i686 package is available.
> >
> > It does the same for ARM with ARMv3, ARMv4 etc.
> 
> That sounds plausible.

That sounds like doubt.

I've used rpm extensively over the last 10 years or so, both on x86 and
ARM.  I've built many versions of Red Hat and Fedora for ARM.  My ARM
machines here (including the one which is going to send this email) run
the result of that - and is currently a mixture of ARMv3 and ARMv4
Fedora packages.
