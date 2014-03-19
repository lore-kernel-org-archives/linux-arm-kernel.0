From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 19 Mar 2014 13:02:33 -0400
Subject: [PATCH] ARM: Remove extraneous kcmp syscall ignore
In-Reply-To: <1392403099-13411-1-git-send-email-cov@codeaurora.org>
References: <1392403099-13411-1-git-send-email-cov@codeaurora.org>
Message-ID: <5329CDA9.7000707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 01:38 PM, Christopher Covington wrote:
> The kcmp system call was ported to ARM in
> commit 3f7d1fe108dbaefd0c57a41753fc2c90b395f458
> "ARM: 7665/1: Wire up kcmp syscall".
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm/include/asm/unistd.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> index 141baa3..cbd6197 100644
> --- a/arch/arm/include/asm/unistd.h
> +++ b/arch/arm/include/asm/unistd.h
> @@ -48,6 +48,5 @@
>   */
>  #define __IGNORE_fadvise64_64
>  #define __IGNORE_migrate_pages
> -#define __IGNORE_kcmp
>  
>  #endif /* __ASM_ARM_UNISTD_H */

Seeing no objections, will add to the patch tracker.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
