From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Oct 2012 12:47:23 +0100
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023114130.GW4477@opensource.wolfsonmicro.com>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
 <20121023114130.GW4477@opensource.wolfsonmicro.com>
Message-ID: <20121023114723.GU21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:41:31PM +0100, Mark Brown wrote:
> On Tue, Oct 23, 2012 at 12:16:56PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Oct 23, 2012 at 12:10:19PM +0100, Mark Brown wrote:
> 
> > > I *really* should not need to remind you to:
> 
> > >  - Not top post
> > >  - Send patches in a form which can be applied if you want them applying
> 
> > How about actually applying the damned patch from the two-part patch set,
> > rather than only the first, both of which has been around for almost a
> > month now, and fixes what should never have gone into mainline in the
> > first place?
> 
> Well, the reason for the second point is that I don't have a copy of the
> patch any more, I need a copy of it before I can do anything.  Half the
> reason these contentless top posts are annoying is that even if there's
> something to do it's not actionable.
> 
> I have to say I had been under the impression that Linus' series that I
> applied the other day dealt with all the outstanding stuff here; the
> issues with this have been the awful changelogs and the overalapping
> sets of patches.

Given that Linus is the one who introduced the fuckups in the first place,
and afaics Linus' series has not been posted anywhere I can see, and I
have been through the issues and worked with Ulf to get them fixed, I find
that to be down right insulting by you.

You received *BOTH* of Ulf's patches on the 5th October.  Both needed
to be applied *TOGETHER* to reduce the window where things got worse
before they got better.  But for some goddamned unknown reason you decided
to only take the first but totally and utterly ignored the second.

Well done, you've probably crapped this driver up again.  Way to go Mark.
Now, tell us _exactly_ what patches you've applied to this driver.  Post
them to this mailing list so we can see them, and see what state this
driver is now in.

IMHO, you're being a terrible "maintainer" here - and this is being shown
by the need to get you to post all the patches you've currently queued up
for this.
