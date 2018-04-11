From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Wed, 11 Apr 2018 12:31:01 +0100
Subject: arm64: Remove duplicate include
In-Reply-To: <8d572a80-36d2-05ba-97ae-4879bc6cb560@arm.com>
References: <1523442286-11714-1-git-send-email-vincenzo.frascino@arm.com>
 <8d572a80-36d2-05ba-97ae-4879bc6cb560@arm.com>
Message-ID: <23b87fc3-80dd-4498-a341-dd353c20d0f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2018 11:54 AM, Sudeep Holla wrote:

> While at this, can you fix other instances too:
> arch/arm64/include/asm/kvm_mmu.h: asm/cpufeature.h
> arch/arm64/kernel/fpsimd.c: linux/prctl.h
> arch/arm64/kernel/ptrace.c: linux/compat.h
>
Ok, I will do in the next version.

Regards,
Vincenzo
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
