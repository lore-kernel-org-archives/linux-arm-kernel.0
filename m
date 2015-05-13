From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 13 May 2015 20:16:54 +0200
Subject: [PATCH] ARM: BCM5301X: Fix chip typo in ARCH_BCM_5301X help
 message
In-Reply-To: <55538A6A.8000203@gmail.com>
References: <1431501645-3887-1-git-send-email-zajec5@gmail.com>
 <55538A6A.8000203@gmail.com>
Message-ID: <CACna6rwp0mPmZJHUpyyR8aubmp9W3+8zi0J1Crgtzj9Ld0f=QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 May 2015 at 19:31, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 13/05/15 00:20, Rafa? Mi?ecki wrote:
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>> ---
>>  arch/arm/mach-bcm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index 8b11f44..7fec7e8 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -47,7 +47,7 @@ config ARCH_BCM_5301X
>>         BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
>>         BCM4708 and BCM4709.
>>
>> -       Do not confuse this with the BCM4760 which is a totally
>> +       Do not confuse this with the BCM4706 which is a totally
>>         different SoC or with the older BCM47XX and BCM53XX based
>>         network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
>
> This is not a real typo per-se, there is a 4760 chip (GPS), do you want
> to resubmit to include both?

Oops, drop it please.

-- 
Rafa?
