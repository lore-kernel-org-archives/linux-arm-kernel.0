From: richard@nod.at (Richard Weinberger)
Date: Sun, 09 Feb 2014 21:02:26 +0100
Subject: [PATCH 12/28] Remove GENERIC_TIME
In-Reply-To: <1391972239.567717844@f148.i.mail.ru>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-13-git-send-email-richard@nod.at>
 <1391972239.567717844@f148.i.mail.ru>
Message-ID: <52F7DED2.1020509@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.02.2014 19:57, schrieb Alexander Shiyan:
>> The symbol is an orphan, get rid of it.
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>> ---
>> arch/arm/mach-bcm/Kconfig | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> index b1aa6a9..8dd5fbf 100644
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -19,7 +19,6 @@ config ARCH_BCM_MOBILE
>> select CPU_V7
>> select CLKSRC_OF
>> select GENERIC_CLOCKEVENTS
>> -	select GENERIC_TIME
>> select GPIO_BCM_KONA
>> select SPARSE_IRQ
>> select TICK_ONESHOT
>> -- 
>> 1.8.4.2
> 
> I sent a similar patch in November, maintainers nothing did with it.
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/278293

Then it is time to push it. :D

Thanks,
//richard
