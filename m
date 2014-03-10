From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Mar 2014 12:36:12 +0100
Subject: [PATCH V2 1/5] ARM: shmobile: r8a7791: add IIC0/1 clock macros
In-Reply-To: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
Message-ID: <9236675.ot3B0M2rgc@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patches.

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Monday 10 March 2014 12:26:56 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> ---
> 
> Changes since V1: kept sorting intact
> 
>  include/dt-bindings/clock/r8a7791-clock.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/r8a7791-clock.h
> b/include/dt-bindings/clock/r8a7791-clock.h index
> 30f82f286e29..2df1a11faeb3 100644
> --- a/include/dt-bindings/clock/r8a7791-clock.h
> +++ b/include/dt-bindings/clock/r8a7791-clock.h
> @@ -51,6 +51,8 @@
>  #define R8A7791_CLK_SDHI1		12
>  #define R8A7791_CLK_SDHI0		14
>  #define R8A7791_CLK_MMCIF0		15
> +#define R8A7791_CLK_IIC0		18
> +#define R8A7791_CLK_IIC1		23
>  #define R8A7791_CLK_SSUSB		28
>  #define R8A7791_CLK_CMT1		29
>  #define R8A7791_CLK_USBDMAC0		30

-- 
Regards,

Laurent Pinchart
