From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Nov 2013 16:10:32 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <20131118150455.GD24408@sirena.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <3371903.8j54vrCjEN@wuerfel> <20131118150455.GD24408@sirena.org.uk>
Message-ID: <201311181610.33105.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013, Mark Brown wrote:
> On Sun, Nov 17, 2013 at 07:10:51PM +0100, Arnd Bergmann wrote:
> > On Sunday 17 November 2013 17:18:03 Stefano Stabellini wrote:
> 
> > > Simply using DT would help avoiding the awkward situation where a driver
> > > of a device only works with one of the two description formats and not
> > > the other.
> 
> > Yes, but remember that Intel still have the problem on their embedded
> > systems, and will want to solve them.
> 
> Has it been confirmed that Intel are going with ACPI for their embedded
> devices rather than SFI?  That would be nice given how awful SFI is and
> I have heard that before but I'm not sure I've seen anything official.

Possibly not all of Intel agrees to that, but I think that's what I've 
heard from Darrent Hart and David Woodhouse. I doubt you can get an
"official" confirmation about it. I also don't know if there is a follow-up
for the Intel CE4100 that started using DT[1].

	Arnd

[1] arch/x86/platform/ce4100/falconfalls.dts
