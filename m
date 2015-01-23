From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 18:10:41 +0000
Subject: [Resend Patch v4 03/16] smp, ARM64: Kill SMP single function
 call interrupt
In-Reply-To: <1421991416-20297-4-git-send-email-jiang.liu@linux.intel.com>
References: <1421991416-20297-1-git-send-email-jiang.liu@linux.intel.com>
 <1421991416-20297-4-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150123181041.GH9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:36:42AM +0000, Jiang Liu wrote:
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I queued the arm64 patch for 3.20. Thanks.

-- 
Catalin
