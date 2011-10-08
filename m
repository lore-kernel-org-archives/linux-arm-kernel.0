From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 8 Oct 2011 21:26:21 +0200
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20111008192621.GA28049@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2011 at 05:19:48PM +0200, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

I think this file is maintained by Russell, yet I want to ack that the entry
below is missing for building mx1_defconfig. Found that, too.

Regards,

   Wolfram

> ---
>  arch/arm/tools/mach-types |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index fff68d0..07811a7 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -188,6 +188,7 @@ omap_2430sdp		MACH_OMAP_2430SDP	OMAP_2430SDP		900
>  davinci_evm		MACH_DAVINCI_EVM	DAVINCI_EVM		901
>  palmz72			MACH_PALMZ72		PALMZ72			904
>  nxdb500			MACH_NXDB500		NXDB500			905
> +apf9328			MACH_APF9328		APF9328			906
>  palmt5			MACH_PALMT5		PALMT5			917
>  palmtc			MACH_PALMTC		PALMTC			918
>  omap_apollon		MACH_OMAP_APOLLON	OMAP_APOLLON		919
> -- 
> 1.7.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111008/616e92ce/attachment.sig>
