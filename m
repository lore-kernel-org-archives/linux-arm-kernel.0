From: dwalker@fifo99.com (Daniel Walker)
Date: Thu, 01 Dec 2011 11:53:27 -0800
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <20111201194353.GA24293@huya.qualcomm.com>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
 <1322752657.3704.2.camel@m0nster>
 <20111201181736.GA13182@huya.qualcomm.com>
 <1322764745.3704.9.camel@m0nster>
 <20111201192705.GA23641@huya.qualcomm.com>
 <1322767992.3704.13.camel@m0nster>
 <20111201194353.GA24293@huya.qualcomm.com>
Message-ID: <1322769207.3704.19.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-01 at 11:43 -0800, David Brown wrote:
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

You didn't CC me on that (or I didn't see it) .. You know who supports
the G1 target and who has the target (i.e. me) .. It also goes against
the philosophy of this community to arbitrarily remove hardware support.

Am I trying to be harsh? No I'm not, but you really shouldn't be doing
this kind of stuff.

Daniel
