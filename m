From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 17 Dec 2016 09:45:28 +0530
Subject: [PATCH v8 2/8] ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
In-Reply-To: <20161216180401.GA6459@kozik-lap>
References: <1481375323-29724-1-git-send-email-pankaj.dubey@samsung.com>
 <1481375323-29724-3-git-send-email-pankaj.dubey@samsung.com>
 <20161216180401.GA6459@kozik-lap>
Message-ID: <CAGcde9H6OhGWhcg_1dVAtq6LnWhB=CkMezQwq0bdWSnRNP72xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 16 December 2016 at 23:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Sat, Dec 10, 2016 at 06:38:37PM +0530, Pankaj Dubey wrote:
>> As now we have chipid driver to initialize SoC related information
>> lets include it in build by default.
> s/lets/let's/
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>

Thanks for review. Will fix minor nitpick in v9 and include your
Reviewed-by tag.

Pankaj Dubey
> Best regards,
> Krzysztof
>
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 0bb63b8..29065c5 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -16,6 +16,7 @@ menuconfig ARCH_EXYNOS
>>       select ARM_AMBA
>>       select ARM_GIC
>>       select COMMON_CLK_SAMSUNG
>> +     select EXYNOS_CHIPID
>>       select EXYNOS_THERMAL
>>       select EXYNOS_PMU
>>       select EXYNOS_SROM
>> --
>> 2.7.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
