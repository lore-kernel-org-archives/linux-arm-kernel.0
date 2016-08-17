From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Aug 2016 11:30:06 +0100
Subject: [PATCH] arm64: Expose TASK_SIZE to userspace via auxv
In-Reply-To: <20160816183231.21179-1-cov@codeaurora.org>
References: <20160816183231.21179-1-cov@codeaurora.org>
Message-ID: <20160817103006.GB20762@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 02:32:29PM -0400, Christopher Covington wrote:
> Some userspace applications need to know the maximum virtual address they can
> use (TASK_SIZE).

Just curious, what are the cases needing TASK_SIZE in user space?

-- 
Catalin
