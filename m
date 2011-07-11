From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 11 Jul 2011 22:19:24 +0800
Subject: [PATCH 06/17] mach-shark: retire custom LED code
In-Reply-To: <20110710093007.GU4812@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-7-git-send-email-bryan.wu@canonical.com>
	<20110710093007.GU4812@n2100.arm.linux.org.uk>
Message-ID: <CAK5ve-+pDTSu+b7sPOoTG4d1mPuMYeg8hnHqg8x4poagvHE3oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 5:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 06, 2011 at 08:34:36PM +0800, Bryan Wu wrote:
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 9adc278..df971c7 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -783,6 +783,12 @@ config ARCH_SHARK
>> ? ? ? select ZONE_DMA
>> ? ? ? select PCI
>> ? ? ? select ARCH_USES_GETTIMEOFFSET
>> + ? ? select NEW_LEDS
>> + ? ? select LEDS_CLASS
>> + ? ? select LEDS_TRIGGERS
>> + ? ? select LEDS_TRIGGER_CPU
>> + ? ? select LEDS_TRIGGER_HEARTBEAT
>> + ? ? select LEDS_TRIGGER_DEFAULT_ON
>
> So Shark too gets forced to have LED support no matter what. ?Can we
> please stop this madness.
>

I will remove them

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
