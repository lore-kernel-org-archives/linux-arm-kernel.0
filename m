From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 4 Jan 2016 12:22:51 +0000
Subject: [PATCH v6] arm/arm64: add arm-smccc
In-Reply-To: <20160104111627.GB19062@n2100.arm.linux.org.uk>
References: <1449667495-23091-1-git-send-email-jens.wiklander@linaro.org>
 <20151221111455.GA11145@red-moon> <20151222094606.GA30272@ermac>
 <20151222121449.GE8644@n2100.arm.linux.org.uk>
 <20160104101323.GA24963@red-moon>
 <20160104111102.GA19062@n2100.arm.linux.org.uk>
 <20160104111627.GB19062@n2100.arm.linux.org.uk>
Message-ID: <20160104122251.GB698@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:16:27AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 04, 2016 at 11:11:02AM +0000, Russell King - ARM Linux wrote:
> > The reason I said what I did above was to head-off the merge window
> > opening last night, and having a rushed job dealing with problems
> > with patches merged at the last minute.
> > 
> > Consider that the period 24th December to 3rd January does not exist
> > for many as far as working on the kernel is concerned, and linux-next
> > probably wasn't running over that period either.
> > 
> > The situation has changed though; last night, Linus released -rc8,
> > which means we have one week of breathing space before the merge window
> > is likely to open, and we have four days of linux-next trees.
> > 
> > This means that I'm willing to take patches today (and today only), as
> > it will give the remainder of the week (up to Thursday - due to the
> > linux-next timing) to sort out any deficiencies in those patches.
> 
> That all said, 8486/1 _is_ the patch you've just asked me to merge,
> which has open questions from Jens that you (Lorenzo) have _not_
> responded to.
> 
> Jens was asking, in response to your feedback, whether an alternative
> Kconfig structure would satisfy your feedback... to which he's had no
> reply from you.  So, we're waiting on your response.

Sorry for the delay in replying. I re-tested 8486/1 on top of Jens'
v7, it is all fine, I commented on the config structure which is
a change that does not affect 8486/1 so if it is ok with you I am happy
for 8486/1 to be applied on top of Jens' series (I guess he should be
sending a v8 today which should be final).

As a heads-up, 8486/1 also depends on 8485/1 that you have already applied.

Thanks,
Lorenzo
