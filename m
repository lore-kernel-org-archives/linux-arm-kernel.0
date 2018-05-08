From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 10:10:24 +0100
Subject: [PATCH v5 04/14] KVM: arm64: Convert lazy FPSIMD context switch
 trap to C
In-Reply-To: <1525449935-31424-5-git-send-email-Dave.Martin@arm.com>
References: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
 <1525449935-31424-5-git-send-email-Dave.Martin@arm.com>
Message-ID: <31599e78-681f-4227-b3aa-c4d934e16c61@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 17:05, Dave Martin wrote:
> To make the lazy FPSIMD context switch trap code easier to hack on,
> this patch converts it to C.
> 
> This is not amazingly efficient, but the trap should typically only
> be taken once per host context switch.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
