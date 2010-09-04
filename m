From: agruen@suse.de (Andreas Gruenbacher)
Date: Sat, 4 Sep 2010 23:46:11 +0200
Subject: [bug-patch] Re: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100904214527.GA20444@n2100.arm.linux.org.uk>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<201009042333.51419.agruen@suse.de>
	<20100904214527.GA20444@n2100.arm.linux.org.uk>
Message-ID: <201009042346.11787.agruen@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 September 2010 23:45:27 Russell King - ARM Linux wrote:
> It also makes them incompatible with GNU patch, whether or not GNU patch
> understands the GIT headers.

Aha?  Then why do you think GNU patch tries to understand the GIt patch 
headers?  So that it can be incompatible with GIT?

Andreas
