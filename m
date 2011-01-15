From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 13:44:16 +0000
Subject: [GIT PULL] Samsung S5P for 2.6.38 merge window
In-Reply-To: <20110115132955.GA15996@n2100.arm.linux.org.uk>
References: <021901cbb2e2$ef4a0630$cdde1290$%kim@samsung.com>
	<20110115132955.GA15996@n2100.arm.linux.org.uk>
Message-ID: <20110115134416.GB15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 01:29:55PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 13, 2011 at 02:30:01PM +0900, Kukjin Kim wrote:
> > Hi Russell,
> > 
> > Please pull Samsung S5P updates from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > for-rmk
> > 
> > These things are for 2.6.38.
> 
> This looks very large.  I really considered not merging this due to:
> 
> 1. possibly conflicts with Lennert's irq_data conversion patches.
> 
> 2. It's not right to push large quantities of code into mainline towards
>    the end of the merge window.  You should have everything prepared
>    that you want to send before the merge window opens.
> 
> In future, please have your tree ready for merging *before* the merge
> window opens and aim to get the bulk in preferably before, at the latest
> during the first week.

And... merging this kills off the ability to get a sane diffstat out
of git for my devel-stable branch due to multiple common ancestors.

We'll see what Linus says on this - but there are three outcomes:

1. Linus responds quickly, and wants his tree merged into mine before
   he pulls (Linus isn't generally a fan of last minute cross-tree
   merging.)

2. Linus doesn't respond before the merge window closes, and I leave the
   tree as is, which means no pull request being sent and therefore it
   doesn't make mainline.

3. Linus doesn't respond before the merge window closes, I decide to
   drop your tree, and send a pull request which Linus actions.

Realistically, it's (1) or (3).

This is yet another reason to get your tree ready before the merge
window opens.
