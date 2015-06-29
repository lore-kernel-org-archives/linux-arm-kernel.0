From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Jun 2015 05:50:36 +0200
Subject: [PATCH RFC] MAINTAINERS: Update Zynq git tree location
In-Reply-To: <1435334672-8825-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1435334672-8825-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5590C08C.6020001@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2015 06:04 PM, Soren Brinkmann wrote:
> The git tree for Zynq moved to Github. Update the MAINTAINERS record to
> reflect the change.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a01df3088b01..f6b16941ae08 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,7 +1639,7 @@ M:	Michal Simek <michal.simek@xilinx.com>
>  R:	S?ren Brinkmann <soren.brinkmann@xilinx.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  W:	http://wiki.xilinx.com
> -T:	git git://git.xilinx.com/linux-xlnx.git
> +T:	git https://github.com/Xilinx/linux-xlnx.git
>  S:	Supported
>  F:	arch/arm/mach-zynq/
>  F:	drivers/cpuidle/cpuidle-zynq.c
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

I will add it to my branch if someone else doesn't want it.

Thanks,
Michal
