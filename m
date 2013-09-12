From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Sep 2013 10:14:29 +0100
Subject: [RFC PATCH v2 05/25] smp, ARM64: kill SMP single function call
 interrupt
In-Reply-To: <1378915649-16395-6-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
 <1378915649-16395-6-git-send-email-liuj97@gmail.com>
Message-ID: <20130912091429.GC15357@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 05:07:09PM +0100, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
