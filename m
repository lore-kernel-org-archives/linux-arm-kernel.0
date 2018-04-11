From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 Apr 2018 11:54:40 +0100
Subject: arm64: Remove duplicate include
In-Reply-To: <1523442286-11714-1-git-send-email-vincenzo.frascino@arm.com>
References: <1523442286-11714-1-git-send-email-vincenzo.frascino@arm.com>
Message-ID: <8d572a80-36d2-05ba-97ae-4879bc6cb560@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(nit: missing PATCH in the $subject, also cc maintainers, you can use
scripts/maintainers.pl to get the list)

On 11/04/18 11:24, Vincenzo Frascino wrote:
> In armv8_deprecated asm/cpufeature.h has been included twice.
> 
> This patch removes the double inclusion.
> 

While at this, can you fix other instances too:

arch/arm64/include/asm/kvm_mmu.h: asm/cpufeature.h
arch/arm64/kernel/fpsimd.c: linux/prctl.h
arch/arm64/kernel/ptrace.c: linux/compat.h

-- 
Regards,
Sudeep
