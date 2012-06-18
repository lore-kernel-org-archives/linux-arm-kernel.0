From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 18 Jun 2012 14:29:13 -0400 (EDT)
Subject: mach/io.h cleanup and removal question
In-Reply-To: <20120618075945.GJ4799@lunn.ch>
References: <20120608102040.GA26034@lunn.ch>
 <20120608114316.GC15555@n2100.arm.linux.org.uk> <4FD207C9.5010006@gmail.com>
 <20120618075945.GJ4799@lunn.ch>
Message-ID: <alpine.LFD.2.02.1206181414340.23555@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Jun 2012, Andrew Lunn wrote:
> On Fri, Jun 08, 2012 at 09:10:17AM -0500, Rob Herring wrote:
> > Do you have cards with i/o that you can test or know what devices are
> > used with this platform?
> 
> I don't have any cards. I've also no idea what cards are used with
> these devices. I guess they are mostly WiFi cards, since Orion5x is
> normally used in NAS boxes, and there is one box supported which is an
> WiFi AP.

Those are also mini PCI-E cards, and I would be very surprised if one 
could ever find such a card making use of the PCI I/O space.  So this 
might prove very difficult to actually test this support, and I can't 
remember if the current code was ever confirmed to work in the first 
place because of no available cards.  So the best thing that can be done 
is to make sure it looks right from a theoretical point of view.


Nicolas
