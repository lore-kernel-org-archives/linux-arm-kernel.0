From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 19:14:30 +0200
Subject: [PATCH V5 0/6] USB: EHCI multiplatform for 3.10
In-Reply-To: <20130408164209.GA13694@kroah.com>
References: <1364919844-1726-1-git-send-email-arnd@arndb.de>
 <20130408164209.GA13694@kroah.com>
Message-ID: <201304081914.30266.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Greg KH wrote:
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
> 
> I've applied the first 5 for now, if you want the 6th one applied,
> please resend.

Thanks a lot!

I had mentioned the fact that the last one is missing the ack in my
email, maybe not prominently enough when I wrote:

> > * The final patch is from me and still waiting for an Ack from Alan
> >   Stern, so please wait for his feedback before applying that one.

It would be nice to get that in, but it's not as important for 3.10 since
the only conflict between backends I expect is between Exynos and SPEAr.
SPEAr is not widely used for all I can tell, and whether Exynos actually
makes the multiplatform conversion is still an open question, since there
are a number of missing patches and we are about to close the window for
arm-soc patches as well. In 3.11, things will look quite different.

	Arnd
