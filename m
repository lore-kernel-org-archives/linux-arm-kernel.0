From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 27 Apr 2015 07:22:54 +0200
Subject: [PATCH] [media] xilinx: Reflect dma header file move
In-Reply-To: <1429903476-24161-1-git-send-email-linux@roeck-us.net>
References: <1429903476-24161-1-git-send-email-linux@roeck-us.net>
Message-ID: <fcd18355-b06d-4afd-b8c3-9af9adcf8021@BY2FFO11OLC013.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2015 09:24 PM, Guenter Roeck wrote:
> Commit 937abe88aea3 ("dmaengine: xilinx-dma: move header file to common
> location") moved xilinx_dma.h to a common location but neglected to reflect
> this move in all its users.
> 
> This causes compile errors for several builds.
> 
> drivers/media/platform/xilinx/xilinx-dma.c:15:35:
> 	fatal error: linux/amba/xilinx_dma.h: No such file or directory
> 
> Cc: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
> Fixes: 937abe88aea3 ("dmaengine: xilinx-dma: move header file to common
> 	location")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/media/platform/xilinx/xilinx-dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI:
http://www.serverphorums.com/read.php?12,1179281

https://lkml.org/lkml/2015/4/25/25

Thanks,
Michal
