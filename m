From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 20 Jul 2012 13:31:02 +0200 (CEST)
Subject: [PATCH] media: mx2_camera: Remove MX2_CAMERA_SWAP16 and
 MX2_CAMERA_PACK_DIR_MSB flags.
In-Reply-To: <1342083809-19921-1-git-send-email-javier.martin@vista-silicon.com>
References: <1342083809-19921-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <Pine.LNX.4.64.1207201330240.27906@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Jul 2012, Javier Martin wrote:

> These flags are not used any longer and can be safely removed
> since the following patch:
> http://www.spinics.net/lists/linux-media/msg50165.html
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

For the ARM tree:

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  arch/arm/plat-mxc/include/mach/mx2_cam.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx2_cam.h b/arch/arm/plat-mxc/include/mach/mx2_cam.h
> index 3c080a3..7ded6f1 100644
> --- a/arch/arm/plat-mxc/include/mach/mx2_cam.h
> +++ b/arch/arm/plat-mxc/include/mach/mx2_cam.h
> @@ -23,7 +23,6 @@
>  #ifndef __MACH_MX2_CAM_H_
>  #define __MACH_MX2_CAM_H_
>  
> -#define MX2_CAMERA_SWAP16		(1 << 0)
>  #define MX2_CAMERA_EXT_VSYNC		(1 << 1)
>  #define MX2_CAMERA_CCIR			(1 << 2)
>  #define MX2_CAMERA_CCIR_INTERLACE	(1 << 3)
> @@ -31,7 +30,6 @@
>  #define MX2_CAMERA_GATED_CLOCK		(1 << 5)
>  #define MX2_CAMERA_INV_DATA		(1 << 6)
>  #define MX2_CAMERA_PCLK_SAMPLE_RISING	(1 << 7)
> -#define MX2_CAMERA_PACK_DIR_MSB		(1 << 8)
>  
>  /**
>   * struct mx2_camera_platform_data - optional platform data for mx2_camera
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
