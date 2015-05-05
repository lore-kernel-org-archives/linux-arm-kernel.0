From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 5 May 2015 22:03:52 +0200
Subject: [rtc-linux] [PATCH v3 3/3] MAINTAINERS: add Mediatek RTC driver
In-Reply-To: <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-4-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150505200352.GQ4276@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28/04/2015 at 15:35:56 +0800, Eddie Huang wrote :
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e5bbc0..eb80610 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1223,6 +1223,13 @@ W:	http://www.digriz.org.uk/ts78xx/kernel
>  S:	Maintained
>  F:	arch/arm/mach-orion5x/ts78xx-*
>  
> +ARM/Mediatek RTC DRIVER
> +M:	Eddie Huang <eddie.huang@mediatek.com>
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +L:	linux-mediatek at lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/rtc/rtc-mt*

I feel like this is a bit broad. Unless you want to really maintain
rtc-mt* which I guess may not be only Mediatek in the future, I would
use the full filename here. You will probably remember to update it if
you add more, that may not be the case for other developers.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
