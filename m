From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 18:17:26 +0000
Subject: [PATCH v4] arm64: support single-step and breakpoint handler hooks
In-Reply-To: <1386136220-15171-2-git-send-email-sandeepa.prabhu@linaro.org>
References: <1386136220-15171-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1386136220-15171-2-git-send-email-sandeepa.prabhu@linaro.org>
Message-ID: <20131217181726.GU32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 05:50:20AM +0000, Sandeepa Prabhu wrote:
> AArch64 Single Steping and Breakpoint debug exceptions will be
> used by multiple debug framworks like kprobes & kgdb.
> 
> This patch implements the hooks for those frameworks to register
> their own handlers for handling breakpoint and single step events.
> 
> Reworked the debug exception handler in entry.S: do_dbg to route
> software breakpoint (BRK64) exception to do_debug_exception()
> 
> Signed-off-by: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks. Applied.

-- 
Catalin
