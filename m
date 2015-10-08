From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 8 Oct 2015 17:07:28 +0800
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <56090C08.8070003@huawei.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
 <1783631.jH4WY2RqXu@wuerfel> <5608FA85.8070009@huawei.com>
 <2245172.1ESUGv0DKo@wuerfel> <56090C08.8070003@huawei.com>
Message-ID: <56163250.90207@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/28 17:44, Leizhen (ThunderTown) wrote:
>> > 
>>> >> --------------drivers/char/Kconfig--------------
>>> >> if RTC_LIB=n
>>> >>
>>> >> config RTC
>>> >> tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
>>> >>
>>> >> .......
>>> >>
>>> >> config EFI_RTC
>>> >>         bool "EFI Real Time Clock Services"
>>> >>         depends on IA64 || ARM64
>>> >>
>>> >> .......
>>> >>
>>> >> endif # RTC_LIB
>> > 
>> > The driver you want is RTC_DRV_EFI, not EFI_RTC.
> OK, I will try it tommorrow.

Sorry, the coach called me to learn to drive these days. I opened RTC_DRV_EFI and the RTC worked fine, thanks a lot.

> 
>> > 
>> > 	Arnd
>> > 
>> > .
>> > 
