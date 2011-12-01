From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Dec 2011 20:19:50 +0000
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <20111201194353.GA24293@huya.qualcomm.com>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
 <1322752657.3704.2.camel@m0nster> <20111201181736.GA13182@huya.qualcomm.com>
 <1322764745.3704.9.camel@m0nster> <20111201192705.GA23641@huya.qualcomm.com>
 <1322767992.3704.13.camel@m0nster> <20111201194353.GA24293@huya.qualcomm.com>
Message-ID: <20111201201950.GE9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:43:53AM -0800, David Brown wrote:
> On Thu, Dec 01, 2011 at 11:33:12AM -0800, Daniel Walker wrote:
> > On Thu, 2011-12-01 at 11:27 -0800, David Brown wrote:
> > > On Thu, Dec 01, 2011 at 10:39:05AM -0800, Daniel Walker wrote:
> > > 
> > > > > If someone is willing to step up and make it work, then we can keep it
> > > > > around.  My only G1 is fried, so I have no way to do anything other
> > > > > than keep it compiling.
> > > > 
> > > > Unfortunately, You can't remove it regardless of whether or not you have
> > > > one to test on.. Your job is to do the best you can to keep it working
> > > > and maintained. If you don't have one then you can't boot test but you
> > > > still have to your best to keep it as close to working as possible.
> > > 
> > > I was trying to get an idea if anyone uses the target.  If people
> > > want the target around, we can just ignore my patches to remove it.
> > 
> > Please don't ever do this again.
> 
> That's awfully harsh.  I sent an email a few weeks back asking about
> removing the target, and I only got one positive response.  Sometimes
> sending a patch is the best way to get a reaction.

That's pretty normal for just 'asking' about doing something.

You've done the right thing - if you ask, people treat your message as
low priority and don't bother replying in the hope that nothing will
happen.

However, if you send a patch to delete a platform, people treat it as
most urgent because if they care they need to speak up to actually stop
it happening.  (Even if you intend to only actually submit it in 6
months time or so - but don't mention that in the initial posting!)

Now, the obvious question to ask now is this: as you sent your question,
and Daniel obviously objects, was Daniel one of your respondants?  If
not, then he carries some of the blame for this patch being created
in the first place by having missed the email/not replied/etc.
