From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Feb 2012 11:18:21 -0800
Subject: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
In-Reply-To: <CAMQu2gxRT3X7Q7bg0e-7=3HNKWjfQn7gLw9EQhY=g4U10yDMtg@mail.gmail.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
 <20120210191926.GV1426@atomide.com> <4F3A2025.9000609@ti.com>
 <20120214111420.GG15338@n2100.arm.linux.org.uk>
 <CAMQu2gxRT3X7Q7bg0e-7=3HNKWjfQn7gLw9EQhY=g4U10yDMtg@mail.gmail.com>
Message-ID: <20120214191820.GP1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120214 02:58]:
> On Tue, Feb 14, 2012 at 4:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 14, 2012 at 02:19:41PM +0530, Santosh Shilimkar wrote:
> >> >From 4d1ea22985adfe458275b9ae3e00edc6e41a267f Mon Sep 17 00:00:00 2001
> >> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Date: Thu, 2 Feb 2012 15:59:51 +0530
> >> Subject: [PATCH 1/2] ARM: OMAP4: Move the barrier memboclk_steal() as
> >> part of reserve callback
> >>
> >> Commit 716a3dc{ARM: Add arm_memblock_steal() to allocate memory away
> >> from the kernel} introduced arm_memblock_steal() which lead to
> >> OMAP4_ERRATA_I688 to be broken and needed to be fixed.
> >
> > That is misleading. ?Please don't attribute blame for this breakage to
> > that patch, which has nothing to do with introducing the breakage. ?The
> > errata was broken right from the start.
> 
> That's right and I didn't mean that way.
> This was the same reason, first patch I just mentioned what was wrong
> in the code
> rather than mention of any commit.
> 
> Tony,
> Let me know if you want to add any commit history to the change since
> the issue was actually existing without 'arm_memblock_stea()' commit.
> I think, first change log was good enough from the fix point of view.

OK, makes sense. I'll apply it into fixes as is then.

Regards,

Tony
