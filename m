From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 23 Nov 2012 08:45:28 +0100 (CET)
Subject: =?UTF-8?q?=5BPATCH=20444/493=5D=20media=3A=20remove=20use=20of=20=5F=5Fdevexit?=
In-Reply-To: <1353349642-3677-444-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-444-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.64.1211230843460.14984@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

>  drivers/media/platform/sh_vou.c                          | 2 +-
>  drivers/media/platform/soc_camera/atmel-isi.c            | 2 +-
>  drivers/media/platform/soc_camera/mx2_camera.c           | 2 +-
>  drivers/media/platform/soc_camera/mx3_camera.c           | 2 +-
>  drivers/media/platform/soc_camera/pxa_camera.c           | 2 +-
>  drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c | 2 +-
>  drivers/media/platform/soc_camera/sh_mobile_csi2.c       | 2 +-
>  drivers/media/platform/soc_camera/soc_camera.c           | 2 +-

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
