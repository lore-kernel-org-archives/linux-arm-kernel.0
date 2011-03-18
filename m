From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 15:21:49 +0000
Subject: [PATCH v2 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's
	Kit board
In-Reply-To: <1300461116-6028-8-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-8-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <20110318152149.GN29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2011 at 04:11:54PM +0100, Ithamar R. Adema wrote:
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 9d6feaa..570a990 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -2667,7 +2667,7 @@ msm7x30_surf		MACH_MSM7X30_SURF	MSM7X30_SURF		2679
>  micro2440		MACH_MICRO2440		MICRO2440		2680
>  am2440			MACH_AM2440		AM2440			2681
>  tq2440			MACH_TQ2440		TQ2440			2682
> -lpc2478oem		MACH_LPC2478OEM		LPC2478OEM		2683
> +ea2478devkit		MACH_EA2478DEVKIT	EA2478DEVKIT		2683
>  ak880x			MACH_AK880X		AK880X			2684
>  cobra3530		MACH_COBRA3530		COBRA3530		2685
>  pmppb			MACH_PMPPB		PMPPB			2686

NAK.  When I or anyone else updates this file this change wil get reverted.
