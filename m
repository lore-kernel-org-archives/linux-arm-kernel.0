From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 18:49:12 +0530
Subject: [PATCHv2 03/11] arm: arch_timer: use u64/u32 for register data
In-Reply-To: <1357747640-18594-4-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-4-git-send-email-mark.rutland@arm.com>
Message-ID: <50F01150.3090203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> To ensure the correct size of types, use u64 for the return value of
> arch_timer_get_cnt{p,v}ct, and u32 for arch_timer_rate, matching the
> size of the registers these values are taken from. While we're changing
> them anyway, simplify the implementation of arch_timer_get_cnt{p,v}ct.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
