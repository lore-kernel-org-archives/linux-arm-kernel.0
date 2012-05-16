From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 May 2012 11:20:00 -0400 (EDT)
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A581@IL-MB01.marvell.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515164438.22258885@skate>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A462@IL-MB01.marvell.com>
 <201205161200.59362.arnd@arndb.de>
 <EE71107DF0D1F24FA2D95041E64AB9E801A56AA0A581@IL-MB01.marvell.com>
Message-ID: <alpine.LFD.2.02.1205161114070.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 May 2012, Lior Amsalem wrote:

> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Wednesday, May 16, 2012 3:01 PM
> > To: Lior Amsalem
> > Cc: Thomas Petazzoni; Rob Herring; Ben Dooks; Andrew Lunn; Jason Cooper;
> > Nicolas Pitre; Maen Suleiman; Ben Dooks; Olof Johansson; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH] arm: Add basic support for new Marvell Armada SoC
> > family
> > 
> [snip]
> > 
> > Thanks for the list, very helpful!
> > 
> > So do you think it makes sense to put all of these into mach-orion?
> >
> Well, Orion is old and seems like not the best name for a directory to include 
> all the new platforms.
> We are discussing it internally as well and I'll update with our suggestion.

My suggestion is: mach-mrvl-ebu or plat-mrvl-ebu

Rational: any marketing name is going to be unsuitable for structuring 
common code in the kernel, especially as Marvell has a tendency to reuse 
the same marketing name for different things, as well as different names 
for similar things.  One thing that is common to 
Orion/Kirkwood/Dove/(insert some Armada flavours here)/etc though is 
that they came out of Marvell's EBU division.


Nicolas
