From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jan 2010 22:19:09 +0000
Subject: [PATCH 03/06] ARM: Add sh7372 and AP4EVB support
In-Reply-To: <20100128124101.8982.71955.sendpatchset@rxone.opensource.se>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124101.8982.71955.sendpatchset@rxone.opensource.se>
Message-ID: <20100128221909.GB23471@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:41:01PM +0900, Magnus Damm wrote:
> --- 0001/arch/arm/tools/mach-types
> +++ work/arch/arm/tools/mach-types	2010-01-21 19:51:03.000000000 +0900
> @@ -2578,3 +2578,4 @@ glacier			MACH_GLACIER		GLACIER			2592
>  phrazer_bulldog		MACH_PHRAZER_BULLDOG	PHRAZER_BULLDOG		2593
>  omap3_bulldog		MACH_OMAP3_BULLDOG	OMAP3_BULLDOG		2594
>  pca101			MACH_PCA101		PCA101			2595
> +ap4evb			MACH_AP4EVB		AP4EVB			2630

Note that this'll be included in the mach-types update which'll
probably be pushed to Linus probably tonight.
