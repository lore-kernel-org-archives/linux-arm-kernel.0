From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 14 Jun 2010 21:00:00 +0100
Subject: Request review of device tree documentation
In-Reply-To: <AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
References: <1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>
	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<1276408773.1962.574.camel@pasglop>
	<4C147EA5.3060500@firmworks.com>
	<1276417792.1962.731.camel@pasglop>
	<AANLkTimc12G-YYTd4yQiviY-ijvJ9TzVEmxxaoF43xVR@mail.gmail.com>
Message-ID: <20100614200000.GB7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 11:36:57PM -0600, Grant Likely wrote:
> On Sun, Jun 13, 2010 at 2:29 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Sat, 2010-06-12 at 20:45 -1000, Mitch Bradley wrote:
> >
> >> Either fought or embraced. ?To the extent that it is possible to focus
> >> solely on Linux and ARM, one could image doing a good HAL.
> >
> > That will come with a huge amount of comunity resistance sadly, but I
> > can imagine distros liking it.
> >
> > In general, I much prefer having all the necessary native drivers in the
> > kernel, and the device-tree to provide the right representation, and
> > avoid trying to abstract "methods" via a HAL. It's the Linux philosophy
> > as much as possible (even when defeated by ACPI).
> >
> > But if we're going to be forced by vendors into HALs, we can also make
> > sure that whatever they come up with is half reasonable :-)
> 
> I think there is more to be concerned about regarding binary blobs
> than HALs.  Many of the new SoCs require closed binaries to use all
> the hardware right now (graphics cores in particular).
> 
> Board vendors seem to be taking the plunge and modifying the kernel
> rather than trying to create a HAL for driving board specific
> features.

In my view HALs are a bad idea, they constrain you to one calling method
and make it difficult to evolve support in the kernel. I belive it is
part of the reason that we've always tried to avoid a standardised
kernel driver interface.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
