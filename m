From: roy.lists@gmail.com (Roy Franz (HPE))
Date: Fri, 15 Apr 2016 09:17:15 -0700
Subject: [PATCH 3/3] arm64: defconfig: Enable ACPI
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
 <1460706823-16566-3-git-send-email-broonie@kernel.org>
Message-ID: <CAK-u0QkjH-UgPJ0C4UKePQQ-En+XgZigqJROwMFVfd0cQrbEkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 12:53 AM, Mark Brown <broonie@kernel.org> wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Roy Franz <roy.franz@hpe.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a44ef995d8ae..c5e0132eec57 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -264,6 +264,7 @@ CONFIG_PHY_RCAR_GEN3_USB2=y
>  CONFIG_PHY_HI6220_USB=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> +CONFIG_ACPI=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_FANOTIFY=y
> --
> 2.8.0.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
