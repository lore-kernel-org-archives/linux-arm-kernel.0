From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 20 Jan 2014 17:08:32 +0800
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <201401171521.35940.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <201401171521.35940.arnd@arndb.de>
Message-ID: <52DCE790.6080809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-17 22:21, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>>
>> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
>> name from the ACPI timer table is matched with all the registered
>> timer controllers and matching initialisation routine is invoked.
> 
> I wouldn't anticipate this infrastructure to be required. Shouldn't all
> ARMv8 machines have an architected timer?

I not sure of this, could anyone can give some guidance? if only arch
timer is available for ARM64, this will make thing very simple.

Thanks
Hanjun
