From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 15:30:25 +0900
Subject: [PATCH] ARM: shmobile: Use r8a7790 suffix for IRQC compat string
In-Reply-To: <1602466.4IFX4QyYPo@avalon>
References: <20131120000740.27032.66529.sendpatchset@w520>
 <1602466.4IFX4QyYPo@avalon>
Message-ID: <20131128063024.GH22413@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 11:11:47AM +0100, Laurent Pinchart wrote:
> Hi Magnus,
> 
> Thank you for the patch.
> 
> On Wednesday 20 November 2013 09:07:40 Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add "renesas,irqc-r8a7790" to the compatible string for IRQC
> > in case of r8a7790. This makes the IRQC follow the same style
> > as the other devices and also makes it more future proof.
> 
> You should update the device tree bindings documentation as well. As there's 
> no such documentation of the irqc, you should create it ;-)

I will submit a patch for this.
