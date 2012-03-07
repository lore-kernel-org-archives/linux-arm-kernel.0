From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 09:41:29 +0000
Subject: [PATCH 0/4] perf IRQ fixes
In-Reply-To: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
Message-ID: <20120307094129.GO17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 03:58:12PM +0000, Will Deacon wrote:
> Hello,
> 
> This series is a set of fixes to the IRQ handling for perf-events on
> ARM. Thanks to Ming Lei for identifying a couple of the issues addressed
> here.
> 
> I tested the xscale2 changes on my Gumstix Verdex (PXA270 although the
> board isn't actually supported in mainline), the v6 changes on a PB1176
> and the v7 changes on a Cortex-A9 vexpress.
> 
> I think all of these are candidates for -stable, although it may be too
> late for the final cut of 3.3.

So do you want these (and the 5th patch) to have a stable tag on them?
