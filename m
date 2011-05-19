From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 19 May 2011 09:08:57 +0530
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <4DD490D1.9040201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2011 02:17 PM, Arnd Bergmann wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fce5e6..942d052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,6 +630,17 @@ S:	Maintained
>  F:	drivers/amba/
>  F:	include/linux/amba/bus.h
>  
> +ARM SUBARCHITECTURES
> +M:	Arnd Bergmann <arnd@arndb.de>
> +M:	Nicolas Pitre <nico@fluxnic.net>
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	arm at kernel.org
> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S:	MAINTAINED
> +F:	arch/arm/mach-*/
> +F:	arch/arm/plat-*/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git
> +

Acked-by: Viresh Kumar <viresh.kumar@st.com>
(As Maintainer of SPEAr Soc from ST Microelectronics)

-- 
viresh
