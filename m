From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Apr 2013 11:03:58 -0700
Subject: OK to use commit 71856843 as base for further omap clean up?
In-Reply-To: <20130403165353.GW30923@n2100.arm.linux.org.uk>
References: <20130319175921.GA22104@atomide.com> <5150A60E.2090108@ti.com>
 <20130326232200.GQ30923@n2100.arm.linux.org.uk>
 <20130403165353.GW30923@n2100.arm.linux.org.uk>
Message-ID: <20130403180358.GW10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [130403 09:58]:
> On Tue, Mar 26, 2013 at 11:22:00PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 25, 2013 at 02:31:26PM -0500, Jon Hunter wrote:
> > > Hi Russell,
> > > 
> > > On 03/19/2013 12:59 PM, Tony Lindgren wrote:
> > > > Hi Russell,
> > > > 
> > > > Can we use your commit 71856843 (ARM: OMAP: use consistent error checking)
> > > > as an immutable base for further omap dmtimer and gpmc work?
> > > 
> > > I saw that you updated your clean-up branch. Ok to use the below commit
> > > [1] as a base for some v3.10 updates?
> > 
> > It's still the same commit.  I'm not intending to remove this commit
> > from it, so yes, fine, go ahead.
> 
> *sigh*.  Actually, 4d485661d799e81f98097057d445f4803cef2af0 is buggered
> which is the commit below it.  I said yes too quickly.  Oh well, it'll
> just have to be broken for when it hits mainline now.

Yes we have few branches based on that. Note that the issue reported by
Lothar I just resolved in the omap-for-v3.10/timer branch along with
other conflicts when pulling in Jon's patches, so that might do the trick
assuming there are no other issues.

Regards,

Tony
