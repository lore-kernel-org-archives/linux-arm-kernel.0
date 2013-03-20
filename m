From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 20 Mar 2013 22:22:02 +0800
Subject: [PATCH 0/2] arm: prima2: add support for CSR SiRFatlas6 SoC
In-Reply-To: <201303201113.47164.arnd@arndb.de>
References: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
 <201303201113.47164.arnd@arndb.de>
Message-ID: <CAGsJ_4wtBoFdxZa7GdN8AZU_Va-gkLB6Hs3-Ckey27OzOdHfVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2013/3/20 Arnd Bergmann <arnd@arndb.de>:
> On Monday 18 March 2013, Barry Song wrote:
>> SiRFatlas6 is much similar with SiRFprimaII with some changes about:
>> 1. deleted l2 cache, sdmmc4, multimedia and so on
>> 2. changed pinmux layout and clock layout
>> 3. DMA access limitation disappears, that makes us not need DMA_ZONE
>>    on atlas6
>>
>> Barry Song (2):
>>   arm: prima2: add new SiRFatlas6 machine in common board
>>   ARM/dts: prima2: add .dtsi for atlas6 and .dts for atla6-evb board
>>
>
> It seems I forgot to reply here when I applied these to the next/soc branch.
>
> I have also prepared a series on top of your patches to update mach-prima2
> for multiplatform support that I'll send out for review in a bit.

Thanks very much for your great job on the CSR platform. i will take
some time to test the patch series.

>
>         Arnd
>
-barry
