From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 11:24:07 +0100
Subject: [PATCH 49/74] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <95e9f2e2d8e2a23629760a7dcb7cbab098ff7412.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<95e9f2e2d8e2a23629760a7dcb7cbab098ff7412.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100902102407.GQ26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 30, 2010 at 04:09:13PM +0530, Viresh KUMAR wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c4d1df3..ef92faa 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -822,6 +822,8 @@ config PLAT_SPEAR
>  	select COMMON_CLKDEV
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_CLK
> +	select ARCH_HAS_CPUFREQ
> +

You should avoid this blank line.
>  	help
>  	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
