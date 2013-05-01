From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 May 2013 10:11:08 +0100
Subject: [PATCH 6/4] arm64: Move to generic sched_clock infrastructure
In-Reply-To: <1367369675-13535-2-git-send-email-sboyd@codeaurora.org>
References: <1366417746-24990-1-git-send-email-sboyd@codeaurora.org>
 <1367369675-13535-1-git-send-email-sboyd@codeaurora.org>
 <1367369675-13535-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130501091108.GB10984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 01, 2013 at 01:54:35AM +0100, Stephen Boyd wrote:
> Use the generic sched_clock infrastructure instead of rolling our
> own. This has the added benefit of fixing suspend/resume as
> outlined in 6a4dae5 (ARM: 7565/1: sched: stop sched_clock()
> during suspend, 2012-10-23) and correcting the timestamps when
> the hardware returns a value instead of 0 upon the first read.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looks ok.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
