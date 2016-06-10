From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Jun 2016 04:18:55 -0700
Subject: [PATCH 0108/1529] Fix typo
In-Reply-To: <20160521115032.4966-1-andrea.gelmini@gelma.net>
References: <20160521115032.4966-1-andrea.gelmini@gelma.net>
Message-ID: <20160610111855.GZ22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrea Gelmini <andrea.gelmini@gelma.net> [160521 04:52]:
> --- a/arch/arm/mach-omap2/sdrc.h
> +++ b/arch/arm/mach-omap2/sdrc.h
> @@ -175,8 +175,8 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
>   * don't adjust it down as your clock period increases the refresh interval
>   * will not be met. Setting all parameters for complete worst case may work,
>   * but may cut memory performance by 2x. Due to errata the DLLs need to be
> - * unlocked and their value needs run time calibration.	A dynamic call is
> - * need for that as no single right value exists acorss production samples.
> + * unlocked and their value needs run time calibration. A dynamic call is
> + * need for that as no single right value exists across production samples.

Applying patches 102 - 108 into omap-for-v4.8/soc thanks.

Tony
