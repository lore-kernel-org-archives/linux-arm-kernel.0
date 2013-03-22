From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 17:23:46 +0000
Subject: [PATCH 1/5] ARM: ux500: Add machine support for ccu8540
In-Reply-To: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130322172346.GG4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 03:27:41PM +0000, Lee Jones wrote:
> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> index 831e1fd..1c9d0be 100644
> --- a/arch/arm/tools/mach-types
> +++ b/arch/arm/tools/mach-types
> @@ -1204,3 +1204,4 @@ baileys			MACH_BAILEYS		BAILEYS			4169
>  familybox		MACH_FAMILYBOX		FAMILYBOX		4170
>  ensemble_mx35		MACH_ENSEMBLE_MX35	ENSEMBLE_MX35		4171
>  sc_sps_1		MACH_SC_SPS_1		SC_SPS_1		4172
> +u8540			MACH_U8540		U8540			4211

If you need this updated, please ask. :)
