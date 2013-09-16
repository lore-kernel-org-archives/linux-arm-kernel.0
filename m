From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Sep 2013 08:15:50 -0500
Subject: [PATCH] ARM: multi_v7: add HREFv60 to multi_v7 defconfig
In-Reply-To: <CAL_JsqK=mZJkhyS0pVtvqZSFjO6262xwZuh5Y_VTfuuJk73FuA@mail.gmail.com>
References: <1379334152-9751-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqK=mZJkhyS0pVtvqZSFjO6262xwZuh5Y_VTfuuJk73FuA@mail.gmail.com>
Message-ID: <CAL_Jsq+GDfez+a3EdrEUdZVfj8c8An89NWOW3RCUjvZPf-PrOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 8:11 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, Sep 16, 2013 at 7:22 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> This is just a standard board for the Ux500, include it in the
>> v7 multiplatform defconfig.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Hi ARM SoC folks: this makes also my preferred development board
>> boot with multi_v7. Please apply this patch directly to fixes
>> if you're happy with it.
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 6e572c6..a333753 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -36,6 +36,7 @@ CONFIG_ARCH_TEGRA_114_SOC=y
>>  CONFIG_TEGRA_PCI=y
>>  CONFIG_TEGRA_EMC_SCALING_ENABLE=y
>>  CONFIG_ARCH_U8500=y
>> +CONFIG_MACH_HREFV60=y
>
> This option doesn't seem to actually affect the build in anyway. Same
> with snowball. Why not remove them?

Well, I've already forgotten how mach-types works... So the only
difference is a machine desc included or not. Why not just always
include all machines.

Rob
