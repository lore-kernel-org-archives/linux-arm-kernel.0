From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 8 Feb 2017 18:34:00 -0500
Subject: [PATCH] MAINTAINERS: Add Jon Mason to BCM5301X maintainers
In-Reply-To: <d7b40d59-4121-97ef-9829-405df8042bd7@milecki.pl>
References: <1486596146-26766-1-git-send-email-jon.mason@broadcom.com>
 <d7b40d59-4121-97ef-9829-405df8042bd7@milecki.pl>
Message-ID: <CAC3K-4obNm0LLzsirCqZF9xY-Bwv---m5MeSQuv5Q65=gsngnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 8, 2017 at 6:29 PM, Rafa? Mi?ecki <rafal@milecki.pl> wrote:
> On 02/09/2017 12:22 AM, Jon Mason wrote:
>>
>> Adding myself as a maintainer for Broadcom Northstar SoCs.  Also, adding
>> a regex entry to discover the SVK DTs already present.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>
>
> Acked-by: Rafa? Mi?ecki <rafal@milecki.pl>
>
>
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2abda6c..03c1760 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2641,12 +2641,14 @@ F:      arch/mips/include/asm/mach-bcm47xx/*
>>  BROADCOM BCM5301X ARM ARCHITECTURE
>>  M:     Hauke Mehrtens <hauke@hauke-m.de>
>>  M:     Rafa? Mi?ecki <zajec5@gmail.com>
>> +M:     Jon Mason <jonmason@broadcom.com>
>>  M:     bcm-kernel-feedback-list at broadcom.com
>>  L:     linux-arm-kernel at lists.infradead.org
>>  S:     Maintained
>>  F:     arch/arm/mach-bcm/bcm_5301x.c
>>  F:     arch/arm/boot/dts/bcm5301x*.dtsi
>>  F:     arch/arm/boot/dts/bcm470*
>> +N:     bcm953012

There are 2 now, and a 3rd one coming soon.
./arch/arm/boot/dts/bcm953012k.dts
./arch/arm/boot/dts/bcm953012er.dts

It might be overkill, but I thought it was the way everyone was going
(and seems to be more elegant).  I'll defer if the simpler version is
desired

Thanks,
Jon

>
>
> Is it worth using N: (regex pattern)? Just asking.
