From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Apr 2018 08:32:56 +0100
Subject: [PATCH] MAINTAINERS: Update e-mail address for Christoffer Dall
In-Reply-To: <20180416182831.4035-1-christoffer.dall@arm.com>
References: <20180416182831.4035-1-christoffer.dall@arm.com>
Message-ID: <6bb15fe7-cf20-c4e2-d596-fd9e243659e4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/18 19:28, Christoffer Dall wrote:
> Update my e-mail address to a working address.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..3e9c99d2620b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7738,7 +7738,7 @@ F:	arch/x86/include/asm/svm.h
>  F:	arch/x86/kvm/svm.c
>  
>  KERNEL VIRTUAL MACHINE FOR ARM (KVM/arm)
> -M:	Christoffer Dall <christoffer.dall@linaro.org>
> +M:	Christoffer Dall <christoffer.dall@arm.com>
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm at lists.cs.columbia.edu
> @@ -7752,7 +7752,7 @@ F:	virt/kvm/arm/
>  F:	include/kvm/arm_*
>  
>  KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
> -M:	Christoffer Dall <christoffer.dall@linaro.org>
> +M:	Christoffer Dall <christoffer.dall@arm.com>
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm at lists.cs.columbia.edu
> 

I'll queue this as a fix for the next -rc.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
