From: davidb@codeaurora.org (David Brown)
Date: Thu, 23 Dec 2010 10:15:16 -0800
Subject: Git pull request: ux500-core for the v2.6.38 merge window
In-Reply-To: <20101223144949.GO3636@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Dec 2010 14:49:49 +0000")
References: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
	<20101223144949.GO3636@n2100.arm.linux.org.uk>
Message-ID: <8yak4j0bbkb.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Thu, Dec 23, 2010 at 08:48:26AM +0100, Linus Walleij wrote:

> First, I need to make absolutely sure that the GIC and SMP changes are
> 100% ready and up to date with acks etc.  I think there may be patches
> at the top of the SMP branch which haven't been posted to the list yet
> (or they have but have no acks.)

Jeff Ohlstein also posted some MSM SMP patches which also depend on the
SMP changes.  I haven't put them in linux-next yet because they depend
on your devel tree.

I was intending to wait until the merge window opens, and then base the
patches off of what does end up going into the merge window.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
