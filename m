From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 14 Aug 2013 14:01:59 -0400
Subject: [PATCHv3 1/5] arm64: reorganise smp_enable_ops
In-Reply-To: <1376497228-20543-2-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-2-git-send-email-mark.rutland@arm.com>
Message-ID: <520BC617.8010708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 August 2013 12:20 PM, Mark Rutland wrote:
> For hotplug support, we're going to want a place to store operations
> that do more than bring CPUs online, and it makes sense to group these
> with our current smp_enable_ops.
> 
> This patch renames smp_enable_ops to smp_ops to make the intended use of
> the structure clearer. While we're at it, fix up instances of the cpu
> parameter to be an unsigned int, drop the init markinss and rename the
> *_cpu functions to cpu_* to reduce future churn when smp_operations is
> extended.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
