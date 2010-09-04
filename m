From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 4 Sep 2010 05:21:17 +0200
Subject: [bug-patch] [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <201009040058.18028.agruen@suse.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<201009040058.18028.agruen@suse.de>
Message-ID: <20100904032117.GL17702@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> So "git apply" and "patch --dry-run" seem to work only by accident.
> 
> How was this patch generated: with git itself?
I did as usual
git format-patch -M -B -C HEAD~
> 
> The fact that "patch --dry-run" may not work for patches that modify the same 
> file twice is a known defect.  I don't know how to solve this in a reasonably 
> elegant way.  Luckily the problem only triggers when people are doing 
> something "strange" such as concatenating patches.

Best Regards,
J.
