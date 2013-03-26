From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Mar 2013 23:22:00 +0000
Subject: OK to use commit 71856843 as base for further omap clean up?
In-Reply-To: <5150A60E.2090108@ti.com>
References: <20130319175921.GA22104@atomide.com> <5150A60E.2090108@ti.com>
Message-ID: <20130326232200.GQ30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 02:31:26PM -0500, Jon Hunter wrote:
> Hi Russell,
> 
> On 03/19/2013 12:59 PM, Tony Lindgren wrote:
> > Hi Russell,
> > 
> > Can we use your commit 71856843 (ARM: OMAP: use consistent error checking)
> > as an immutable base for further omap dmtimer and gpmc work?
> 
> I saw that you updated your clean-up branch. Ok to use the below commit
> [1] as a base for some v3.10 updates?

It's still the same commit.  I'm not intending to remove this commit
from it, so yes, fine, go ahead.
