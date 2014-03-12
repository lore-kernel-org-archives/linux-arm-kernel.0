From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 11:32:18 +0100
Subject: [PATCH 3/5] ARM: shmobile: r8a7790: add IIC0-2 clock macros
In-Reply-To: <1394573078-20767-4-git-send-email-wsa@the-dreams.de>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-4-git-send-email-wsa@the-dreams.de>
Message-ID: <5937037.nUVrbBbcM0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patch.

On Tuesday 11 March 2014 22:24:36 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/dt-bindings/clock/r8a7790-clock.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/r8a7790-clock.h
> b/include/dt-bindings/clock/r8a7790-clock.h index
> 6548a5fbcf4a..4d3e935b3f1b 100644
> --- a/include/dt-bindings/clock/r8a7790-clock.h
> +++ b/include/dt-bindings/clock/r8a7790-clock.h
> @@ -50,6 +50,7 @@
>  #define R8A7790_CLK_SYS_DMAC0		19
> 
>  /* MSTP3 */
> +#define R8A7790_CLK_IIC2		0
>  #define R8A7790_CLK_TPU0		4
>  #define R8A7790_CLK_MMCIF1		5
>  #define R8A7790_CLK_SDHI3		11
> @@ -57,6 +58,8 @@
>  #define R8A7790_CLK_SDHI1		13
>  #define R8A7790_CLK_SDHI0		14
>  #define R8A7790_CLK_MMCIF0		15
> +#define R8A7790_CLK_IIC0		18
> +#define R8A7790_CLK_IIC1		23
>  #define R8A7790_CLK_SSUSB		28
>  #define R8A7790_CLK_CMT1		29
>  #define R8A7790_CLK_USBDMAC0		30

-- 
Regards,

Laurent Pinchart
