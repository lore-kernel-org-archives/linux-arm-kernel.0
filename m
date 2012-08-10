From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 10 Aug 2012 12:24:33 -0400
Subject: [36/36] AArch64: MAINTAINERS update
In-Reply-To: <1341608777-12982-37-git-send-email-catalin.marinas@arm.com>
References: <1341608777-12982-37-git-send-email-catalin.marinas@arm.com>
Message-ID: <502535C1.8060907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 07/06/2012 05:06 PM, Catalin Marinas wrote:
> This patch updates the MAINTAINERS file for the AArch64 Linux kernel
> port.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> ---
> MAINTAINERS |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eb22272..50699f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -192,6 +192,12 @@ S:	Supported
>  F:	Documentation/scsi/aacraid.txt
>  F:	drivers/scsi/aacraid/
>  
> +AARCH64 ARCHITECTURE
> +M:	Catalin Marinas <catalin.marinas@arm.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)

I think it's important to include the Linux ARM kernel mailing list as a recipient for these changes and I hope you'll do so in all future revisions of the 64-bit patches.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
