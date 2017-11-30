From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Nov 2017 20:39:21 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171128102025.GT31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
 <20171127175254.GL31757@n2100.armlinux.org.uk>
 <20171127184411.GA19577@piout.net>
 <20171127185352.GN31757@n2100.armlinux.org.uk>
 <20171127193135.GA21126@piout.net>
 <20171128102025.GT31757@n2100.armlinux.org.uk>
Message-ID: <20171130193921.GB21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/2017 at 10:20:25 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 27, 2017 at 08:31:35PM +0100, Alexandre Belloni wrote:
> > On 27/11/2017 at 18:53:52 +0000, Russell King - ARM Linux wrote:
> > > You are, yet again, wrong.
> > > 
> > > I am in a position to make the comment because it was me who identified
> > > the problem, put in the hours to work on, develop and extensively test
> > > Jason's patch.  So, it's partly my time that you seem to be wasting,
> > > and that gives me every right to complain at this point.
> > > 
> > > You, on the other hand, were copied with every single email, and did
> > > nothing to discuss the issue except for the "easy" bits when I posted
> > > a relatively smaller patch - but you ignored the bigger issue.
> > 
> > And this is exactly what you do with other people patches/time when you
> > don't like their changes.
> > You simply ignore the patch series until they go away.
> 
> That is not intentional.
> 

So please, don't assume that I replied late intentionally.

> > I would really expect people merging code in any subsystem to wait for
> > the ack of the maintainer of that subsystem.
> > 
> > I didn't complain about any missing email addresses, I said the RTC ML
> > was not copied but that is didn't matter.
> 
> A mailing list is an email address.
> 

Yes and again, this was a non issue, simply that the patch was not in
the RTC patchwork but that is completely irrelevant to the matter.

> Now you're making crap up.  I've not made any comment about this being
> something that needs fixing urgently.  In fact, as I've said several
> times already, I really don't care what you do with the mainline kernel,
> because I have a fix here locally that I intend to use and maintain
> into the future.  For me, the issue is fixed and resolved, and I intend
> to spend no further time developing any fixes for it.
> 
> My comments are about the _two months_ its taken to get to the stage of
> finding out that you don't like the approach.
> 

Again, sorry, this was not intentional.

> The result of this is, most likely, one of:
> 1. you'll revert the patch (which, incidentally, has no real effect until
>    my other patches get merged) and everyone will either be stuck with a
>    kernel that sets their RTC time wrong when they have NTP installed
> 

Ok, let's not waste everything. I think the main issue is that I still
don't get how this can actually improve the situation with regards to
userspace. Can you share your series so I could maybe understand? I'm
especially interested in how you will handle the pcf8523 (if you did
that of course).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
