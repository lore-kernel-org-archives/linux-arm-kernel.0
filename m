From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 12:22:06 +0100
Subject: [PATCH] PXA: Fix typo in proc-xscale.S
In-Reply-To: <20110428104732.GO31131@pengutronix.de>
References: <1303955164-22197-1-git-send-email-marek.vasut@gmail.com>
	<4DB90DD8.7050406@compulab.co.il>
	<20110428095548.GY17290@n2100.arm.linux.org.uk>
	<4DB942F3.1070601@compulab.co.il>
	<20110428104732.GO31131@pengutronix.de>
Message-ID: <20110428112206.GF17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 12:47:32PM +0200, Uwe Kleine-K?nig wrote:
> another problem is that the patch system is for reviewed patches only.
> If the patch is forgotten before it gets some reply sending it to the
> patch system is wrong (at least for non-trivial patches).

That's where pester power comes in - if its still sitting around
unreviewed a week later (assuming there's no long holidays) then
it needs to be chased.

> Patchwork comes to mind. That doesn't forget patches.
> I think for that to be practical for lakml some automatic delegation
> would be needed though.

I'm not convinced that patchwork ultimately reduces the amount of work
required - I think it moves the workload from the patch submitter to
the folk reviewing patches and applying them, who are already overworked.

We have an army of patch submitters but relatively few people reviewing
and applying, so increasing their workload is not really fair.  We need
the workload for people up the chain of patches (who handle a greater
volume of patches) to be less than those down the chain of patches.

Eg, I'm currently struggling to catch up with the email from the last
six days.  Having spent about six hours over the last two days trying to
work through the backlog, I've made a fairly insignificant dent - about
1100 unread messages yesterday morning to 930 unread messages at around
this point in time.  I estimate at this rate I'll have caught up by end
of next week - probably less because I normally seem to drop 10% of email
on the floor unanswered irrespective of the volume.

I already feel like I need another holiday!
