From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 31 Jul 2013 17:07:19 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <1479410.BSGDrOcRvP@thinkpad>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1441731.8CGUI1tUxh@flatron>
 <1375267057.20042.52.camel@sakura.staff.proxad.net>
 <1479410.BSGDrOcRvP@thinkpad>
Message-ID: <20130731150717.GD4904@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 12:59:59PM +0200, Tomasz Figa wrote:
> On Wednesday 31 of July 2013 12:37:37 Maxime Bizon wrote:
> > 
> > Board files are C code anyone has the skill to edit/understand/refactor.
> > Moving to DT and keep them in tree tightly coupled with the kernel
> > version just adds another layer of indirection for *no purpose*.

+1

That is exactly what I tried to say.

> > Linus started the whole thing some years ago by refusing to pull ARM
> > tree [1]. Reread his post, what he wants is clearly b).
> > 
> > Going a) does not solve any problem. You are just moving churn to
> > somewhere else. We had board files churn, then defconfigs churn, DTS
> > files (and associated drivers) will be next.

And at this rate, we are headed for another Linus ultimatum, sooner or
later.

> > DT is self inflicted pain. It has to be for the greater good.
> 
> It has several benefits over board files that I mentioned above, possible 
> without fully separating them from kernel tree.

Every time a criticism is voiced about DT, the DT people stick their
fingers in their ears and say, "NAH, NAH, NAH, I CAN'T HEAR YOU!"

WRT to DT-as-platform-device, we would rather stick with the C code,
please. Just pushing the configuration tables into an external form
does not simplify the problem. In fact, it creates new problems by
inviting the possibility of a bootloader/DT/kernel mismatch.

Thanks,
Richard
