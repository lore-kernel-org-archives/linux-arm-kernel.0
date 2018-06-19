From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 17:14:10 +0100
Subject: [PATCHv3 00/19] arm64: invoke syscalls with pt_regs
In-Reply-To: <20180619153810.mm4yt3pqjagvjo7p@lakrids.cambridge.arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180619153810.mm4yt3pqjagvjo7p@lakrids.cambridge.arm.com>
Message-ID: <20180619161410.6in5qe5y3ydzbfit@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 04:38:10PM +0100, Mark Rutland wrote:
> From b47791fe74fce8bb48696ab0cdda48a9bae0e397 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Tue, 19 Jun 2018 12:49:54 +0100
> Subject: [PATCH] arm64: don't restore GPRs when context tracking
> 
> Now that syscalls are invoked with pt_regs, we no longer need to ensure
> that the argument regsiters are live in the entry assembly, and it's
> fine to not restore them after context_tracking_user_exit() has
> corrupted them.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
