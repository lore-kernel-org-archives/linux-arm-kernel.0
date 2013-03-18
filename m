From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 17 Mar 2013 19:51:23 -0700
Subject: Linux 3.8.3
In-Reply-To: <87ip4p4wjh.fsf@nemi.mork.no>
References: <20130314184702.GA17860@kroah.com>
 <CAE8XmWoYXyNFQ14e6X+2rkWQyRA=kSdc4J+DNu2Sv+6e9rvZRg@mail.gmail.com>
 <20130317193321.GA15102@arwen.pp.htv.fi>
 <20130317195709.GC4977@n2100.arm.linux.org.uk>
 <87ip4p4wjh.fsf@nemi.mork.no>
Message-ID: <20130318025123.GC3028@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 17, 2013 at 09:10:42PM +0100, Bj?rn Mork wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > Sigh.
> >
> > At times, I really don't know why I bother wasting my time commenting on
> > patches if they just go and agree with them, and promptly ignore them.
> > I pointed out what this should be:
> >
> > http://marc.info/?l=linux-kernel&m=135972750522902&w=2
> >
> > And it was agreed:
> >
> > http://marc.info/?l=linux-kernel&m=135993546317541&w=2
> >
> > But for some reason the wrong patch got merged:
> >
> > http://marc.info/?l=git-commits-head&m=136147889001219&w=2
> >
> > Maybe because it was "simpler" ?  Don't know.  But... well, we now know
> > what the outcome of it was.  Let's try a different technique.  I'm going
> > to say nothing of any real help and hopefully it will get fixed properly.
> > Maybe that'll work.
> 
> To be fair, looking at the commitdate of that commit it was already in
> Greg's tree when you commented on it.  So the discussion you had would
> have to be about a followup-fix to this, and not about that particular
> patch.

Yes, I thought someone was going to send me a follow-on patch to fix
this, that is what Minchan said, after I had committed it.

Anyway, it's a staging driver, if it doesn't build, that's not a big
deal.

greg k-h
