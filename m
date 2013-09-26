From: rob@landley.net (Rob Landley)
Date: Thu, 26 Sep 2013 17:50:19 -0500
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <yw1x38oswrss.fsf@unicorn.mansr.com> (from mans@mansr.com on
 Wed Sep 25 15:49:07 2013)
Message-ID: <1380235819.1974.94@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 03:49:07 PM, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Wed, Sep 25, 2013 at 10:23:06AM -0500, Rob Landley wrote:
> >> On 09/24/2013 09:07:57 PM, Nicolas Pitre wrote:
> >>> It could be as simple as making gas accept an extra argument for
> >>> instructions like dsb and just ignoring it.
> >>
> >> So you prefer I come up with the reversion patches locally and  
> _not_
> >> send them upstream?
> >
> > This is a silly attitude.  What you're effectively saying is that we
> > are never allowed to use any future ARM instructions in any Linux
> > kernel because that might break your precious assembler.
> >
> > I've got news for you.  We're *not* going to listen to that  
> argument.
> >
> > END OF DISCUSSION (everything else is just a waste of time.)

Who am I to argue with capital letters?

> I fully agree.

Actually, I thought this was an armv5l regression. (My objection was to  
requiring a newer toolchain for architectures that built fine under the  
old one. My attention was attracted by the proposed patch to  
Documentation/changes with a global updated for required binutils  
version.)

I've since had a chance to confirm the armv5 build break I saw was just  
normal mid-rc1 noise (since fixed) and this set of patches just applies  
to armv7, which already required a newer binutils, so objection  
withdrawn.

Rob
