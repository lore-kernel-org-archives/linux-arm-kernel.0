From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 7 Jun 2012 17:08:16 -0500
Subject: [PATCH 1/2] arm/dts: OMAP2: Add support for OMAP2420 SDP
In-Reply-To: <1339106813-9962-2-git-send-email-jon-hunter@ti.com>
References: <1339106813-9962-1-git-send-email-jon-hunter@ti.com>
 <1339106813-9962-2-git-send-email-jon-hunter@ti.com>
Message-ID: <4FD12650.9070108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/07/2012 05:06 PM, Jon Hunter wrote:
> Simple DTS file for OMAP2420 SDP adding memory information to allow device-tree
> testing on an OMAP2420 SDP.
> 
> Verified that kernel boots with DT using a simple RAMDISK file-system on
> OMAP2420 SDP.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-sdp.dts |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap2420-sdp.dts
> 
> diff --git a/arch/arm/boot/dts/omap2420-sdp.dts b/arch/arm/boot/dts/omap2420-sdp.dts
> new file mode 100644
> index 0000000..28f5d2d
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap2420-sdp.dts
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/

Oops! I should have made this 2012! Will re-post.

Jon
