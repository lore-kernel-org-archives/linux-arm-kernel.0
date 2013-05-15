From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 15 May 2013 14:05:07 +0200
Subject: [PATCH 2/6] ARM: davinci: dm365 evm: remove init_enable from
 ths7303 pdata
In-Reply-To: <1368619042-28252-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1368619042-28252-1-git-send-email-prabhakar.csengg@gmail.com>
 <1368619042-28252-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <1928313.pnnBGKgv0p@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prabhakar,

Thank you for the patch.

On Wednesday 15 May 2013 17:27:18 Lad Prabhakar wrote:
> From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> 
> remove init_enable from ths7303 pdata as it is no longer exists.

You should move this before 1/6, otherwise you will break bisection.

> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-davinci/board-dm365-evm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c
> b/arch/arm/mach-davinci/board-dm365-evm.c index 2a66743..4e02ae7 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -510,7 +510,6 @@ struct ths7303_platform_data ths7303_pdata = {
>  	.ch_1 = 3,
>  	.ch_2 = 3,
>  	.ch_3 = 3,
> -	.init_enable = 1,
>  };
> 
>  static struct amp_config_info vpbe_amp = {
-- 
Regards,

Laurent Pinchart
