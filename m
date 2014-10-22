From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 22 Oct 2014 08:56:25 +0200
Subject: [PATCH 8/8] MAINTAINERS: add at91 power and memory entries
In-Reply-To: <1413928540-27099-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413928540-27099-9-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141022065625.GK7443@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 11:55:40PM +0200, Alexandre Belloni wrote:
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  MAINTAINERS | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a20df9bf8ab0..e325c81ee2fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -871,6 +871,25 @@ M:	Boris Brezillon <boris.brezillon@free-electrons.com>
>  S:	Maintained
>  F:	drivers/clk/at91
>  
> +ARM/ATMEL AT91 Poweroff driver
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/power/reset/at91-poweroff.c
> +
> +ARM/ATMEL AT91 Reset driver
> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/power/reset/at91-reset.c
> +
> +ARM/ATMEL AT91 SDRAM Controlller driver

Controller

> +M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/memory/atmel-sdramc.c
> +F:	include/soc/atmel/memory.h
> +
>  ARM/CALXEDA HIGHBANK ARCHITECTURE
>  M:	Rob Herring <robh@kernel.org>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
