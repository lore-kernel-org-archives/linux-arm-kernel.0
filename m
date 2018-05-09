From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 10:09:06 +0100
Subject: [PATCH v6 02/15] arm64: Use update{,_tsk}_thread_flag()
In-Reply-To: <1525797900-5548-3-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <6585f198-8e08-5d3f-4984-d5a253beaea7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> This patch uses the new update_thread_flag() helpers to simplify a
> couple of if () set; else clear; constructs.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
