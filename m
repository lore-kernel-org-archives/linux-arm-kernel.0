From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 19:20:27 +0530
Subject: [PATCHv2 10/11] arm64: move from arm_generic to arm_arch_timer
In-Reply-To: <1357747640-18594-11-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-11-git-send-email-mark.rutland@arm.com>
Message-ID: <50F018A3.2050709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> The arch_timer driver supports a superset of the functionality of the
> arm_generic driver, and is not tied to a particular arch.
>
> This patch moves arm64 to use the arch_timer driver, gaining additional
> functionality in doing so, and removes the (now unused) arm_generic
> driver. Timer-related hooks specific to arm64 are moved into
> arch/arm64/kernel/time.c.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
Nice.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
