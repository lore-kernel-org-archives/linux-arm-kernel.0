From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 23 Nov 2012 00:04:41 +0100 (CET)
Subject: =?UTF-8?q?=5BPATCH=20414/493=5D=20mmc=3A=20remove=20use=20of=20=5F=5Fdevexit?=
In-Reply-To: <1353349642-3677-414-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-414-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.64.1211230002530.11581@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

>  drivers/mmc/host/sh_mmcif.c        | 2 +-
>  drivers/mmc/host/tmio_mmc.c        | 2 +-

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
