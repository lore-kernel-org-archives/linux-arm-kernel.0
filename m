From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 5 Nov 2015 14:07:16 +0100
Subject: [RFC PATCH  0/3]perf/core: extend perf_reg and
 perf_sample_regs_intr
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-ID: <20151105130716.GC3604@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 02:16:15AM +0530, Madhavan Srinivasan wrote:
> Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
> and adds offsetof macro for the same. It extends perf_reg_value()
> to use reg idx to decide on struct to return value from.

Why; what's in those regs?
