From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 8 Apr 2013 12:48:33 -0400 (EDT)
Subject: [PATCH V5 0/6] USB: EHCI multiplatform for 3.10
In-Reply-To: <20130408164209.GA13694@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1304081247350.1529-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 8 Apr 2013, Greg KH wrote:

> On Tue, Apr 02, 2013 at 06:23:58PM +0200, Arnd Bergmann wrote:
> > Hi Greg,
> > 
> > Here are the EHCI patches that I think are good for inclusion in 3.10,
> > I hope you are willing to include them after the debacle over these
> > patches in 3.9.
> > 
> > The patches are all logically independent but sorted by priority,
> > so decide for yourself how many you want to take, starting at the
> > first one. The first six patches all have an Ack from Alan Stern
> > and from the respective ARM platform maintainers.
> 
> I don't see an ACK for the 6th patch from Alan, any reason for that?

The last patch was different from all the others.  It changed ohci-hcd, 
not ehci-hcd.  I haven't had time yet to go through it in detail; lots 
of other things on my plate.

Alan Stern
