From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Apr 2010 10:20:47 +0100
Subject: Realview PMU IRQ Registration
In-Reply-To: <20100414180829.GA13275@n2100.arm.linux.org.uk>
References: <000801cadbfc$f836e870$e8a4b950$@deacon@arm.com>
	<20100414180829.GA13275@n2100.arm.linux.org.uk>
Message-ID: <000901cadc7c$eecfed60$cc6fc820$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> On Wed, Apr 14, 2010 at 07:04:47PM +0100, Will Deacon wrote:
> > Hi Russell,
> >
> > I've been pinged by the patch system because patch 6045/1:
> >
> > http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6045/1
> >
> > relies on 5890/1, which is applied in your versatile branch.
> >
> > Would you like me to rebase 6045/1 on to that branch so it can
> > be applied there?
> 
> Yes please.

I've submitted a new version as 6057/1. Since it's based on the
versatile branch, I updated the patch to register PMU IRQs for the
ca9x4 vexpress core tile too.

Cheers,

Will
