From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 21 Jan 2013 10:53:51 +0800
Subject: [PATCH v2 2/9] ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in
 Kconfig
In-Reply-To: <20130116113834.GC10218@e106331-lin.cambridge.arm.com>
References: <1358315610-25001-1-git-send-email-Barry.Song@csr.com>
 <1358315610-25001-2-git-send-email-Barry.Song@csr.com>
 <20130116113834.GC10218@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4zWn2o+v-bQoY58eyPAPD9_5+Nwfv67nwsenSGXTRYiew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/16 Mark Rutland <mark.rutland@arm.com>:
> On Wed, Jan 16, 2013 at 05:53:28AM +0000, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> prima2 and marco have different memory base address. prima2
>> begins from 0 and marco begins from
>
> Runaway commit message.

missed information.... thanks!

>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  arch/arm/Kconfig |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index f95ba14..13f89a2 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -394,6 +394,7 @@ config ARCH_GEMINI
>>  config ARCH_SIRF
>>       bool "CSR SiRF"
>>       select ARCH_REQUIRE_GPIOLIB
>> +     select AUTO_ZRELADDR
>>       select COMMON_CLK
>>       select GENERIC_CLOCKEVENTS
>>       select GENERIC_IRQ_CHIP
>> --
>> 1.7.5.4


-barry
