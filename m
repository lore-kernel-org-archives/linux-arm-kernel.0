From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 31 Jul 2013 17:23:35 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have people
 interested in device tree janitoring / cleanup?]
In-Reply-To: <20130731150717.GD4904@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1479410.BSGDrOcRvP@thinkpad> <20130731150717.GD4904@netboy>
Message-ID: <1999586.84BnWE5EUh@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 of July 2013 17:07:19 Richard Cochran wrote:
> On Wed, Jul 31, 2013 at 12:59:59PM +0200, Tomasz Figa wrote:
> > On Wednesday 31 of July 2013 12:37:37 Maxime Bizon wrote:
> > > Board files are C code anyone has the skill to edit/understand/refactor.
> > > Moving to DT and keep them in tree tightly coupled with the kernel
> > > version just adds another layer of indirection for *no purpose*.
> 
> +1
> 
> That is exactly what I tried to say.

I agree with you to some extent. Don't be so extreme though. As I already 
said, this is not entirely "no purpose", as there are more benefits of having 
device tree than just separation from kernel tree.

> > > Linus started the whole thing some years ago by refusing to pull ARM
> > > tree [1]. Reread his post, what he wants is clearly b).
> > > 
> > > Going a) does not solve any problem. You are just moving churn to
> > > somewhere else. We had board files churn, then defconfigs churn, DTS
> > > files (and associated drivers) will be next.
> 
> And at this rate, we are headed for another Linus ultimatum, sooner or
> later.

(see end of the message)

> > > DT is self inflicted pain. It has to be for the greater good.
> > 
> > It has several benefits over board files that I mentioned above, possible
> > without fully separating them from kernel tree.
> 
> Every time a criticism is voiced about DT, the DT people stick their
> fingers in their ears and say, "NAH, NAH, NAH, I CAN'T HEAR YOU!"

I won't comment this...

> WRT to DT-as-platform-device, we would rather stick with the C code,
> please. Just pushing the configuration tables into an external form
> does not simplify the problem. In fact, it creates new problems by
> inviting the possibility of a bootloader/DT/kernel mismatch.

Care to stop ignoring my points other than those defending ideas (nowhere 
stated as good or bad) from extreme opinions?

I said it many, many times, that a) and b) I proposed are just two extremes. 
It is unlikely that an extreme solution will be the best option to choose. I 
am strongly for something in the middle, just like I wrote in several of my 
previous replies.

This is something that should be commented, not those extreme options.

Best regards,
Tomasz
