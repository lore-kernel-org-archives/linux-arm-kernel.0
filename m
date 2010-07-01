From: andi@firstfloor.org (Andi Kleen)
Date: Thu, 1 Jul 2010 21:38:50 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100701193850.GB3594@basil.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 01, 2010 at 12:28:23PM -0700, Daniel Walker wrote:
> On Thu, 2010-07-01 at 20:02 +0200, Andi Kleen wrote:
> > > What license (name/type) is this?
> > 
> > IANAL, but AFAIK standard wisdom is that "disclaimer in the documentation
> > and/or other materials provided" is generally not acceptable for Linux
> > because it's an excessive burden for all distributors.
> 
> It's the BSD license ..

It's the old version of the BSD license that noone uses anymore because of its ]
problems: it's really a unreasonable burden to include hundreds or thousands of 
attributions for every contributor in every printed manual you ship.

The BSDs have all switched to the "Clause 2" (without this one) because 
of this.

> 
> > Also for me it's still quite unclear why we would want this code at all...
> > It doesn't seem to do anything you couldn't do with the existing interfaces.
> 
> I don't know all that much about what Zach's done here, but from what
> he's said so far it looks like this help to manage lots of IOMMUs on a
> single system.. On x86 it seems like there's not all that many IOMMUs in
> comparison .. Zach mentioned 10 to 100 IOMMUs ..

The current code can manage multiple IOMMUs fine.

-Andi
-- 
ak at linux.intel.com -- Speaking for myself only.
