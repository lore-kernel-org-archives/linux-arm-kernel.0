From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 06 Feb 2017 23:08:15 +0100
Subject: [PATCH] ARM: defconfigs: make NF_CT_PROTO_SCTP and
 NF_CT_PROTO_UDPLITE built-in
In-Reply-To: <CAK8P3a0ms69LLevt5oamJ5h6S3o-Rm_RtR=YCdayU3v+7BCdzw@mail.gmail.com>
 (Arnd Bergmann's message of "Mon, 6 Feb 2017 17:38:45 +0100")
References: <20170203164647.3610978-1-arnd@arndb.de>
 <CAK8P3a0ms69LLevt5oamJ5h6S3o-Rm_RtR=YCdayU3v+7BCdzw@mail.gmail.com>
Message-ID: <87o9yf0y7k.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Feb 3, 2017 at 5:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The symbols can no longer be used as loadable modules, leading to a harmless Kconfig
>> warning:
>>
>> arch/arm/configs/imote2_defconfig:60:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
>> arch/arm/configs/imote2_defconfig:59:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP
>> arch/arm/configs/ezx_defconfig:68:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
>> arch/arm/configs/ezx_defconfig:67:warning: symbol value 'm' invalid for NF_CT_PROTO_SCTP
>>
>> Let's make them built-in.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Added to the fixes branch now, as I see the warnings in kernelci for ARM.
Sure, thanks Arnd.

Cheers.

-- 
Robert
