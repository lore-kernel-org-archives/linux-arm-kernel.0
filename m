From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 22 May 2015 07:44:11 +0200
Subject: [PATCH 3/3] MAINTAINERS: Add entry for xilinx mailbox driver.
In-Reply-To: <1432251450-26352-4-git-send-email-moritz.fischer@ettus.com>
References: <1432251450-26352-1-git-send-email-moritz.fischer@ettus.com>
 <1432251450-26352-4-git-send-email-moritz.fischer@ettus.com>
Message-ID: <555EC22B.1020201@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2015 01:37 AM, Moritz Fischer wrote:
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8e0afb..f1f0d10 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10986,6 +10986,13 @@ M:	John Linn <John.Linn@xilinx.com>
>  S:	Maintained
>  F:	drivers/net/ethernet/xilinx/xilinx_axienet*
>  
> +XILINX MAILBOX DRIVER
> +M:	Moritz Fischer <moritz.fischer@ettus.com>
> +L:	linux-kernel at vger.kernel.org
> +S:	Maintained
> +F:	drivers/mailbox/mailbox-xilinx.c
> +F:	Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> +
>  XILINX UARTLITE SERIAL DRIVER
>  M:	Peter Korsgaard <jacmet@sunsite.dk>
>  L:	linux-serial at vger.kernel.org
> 

Add it directly to the driver patch.

Thanks,
Michal
