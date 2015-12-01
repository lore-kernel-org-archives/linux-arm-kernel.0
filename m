From: xuejiancheng@huawei.com (xuejiancheng)
Date: Tue, 1 Dec 2015 10:56:04 +0800
Subject: [PATCH 2/5] ARM: hisi: enable Hi3519 soc
In-Reply-To: <7hlh9f828y.fsf@deeprootsystems.com>
References: <1448694937-31282-1-git-send-email-xuejiancheng@huawei.com>
 <7hlh9f828y.fsf@deeprootsystems.com>
Message-ID: <565D0C44.6010502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,
   Thank you for your suggestions.

On 2015/12/1 8:02, Kevin Hilman wrote:
> Jiancheng Xue <xuejiancheng@huawei.com> writes:
> 
>> Hi3519 SOC is mainly used for ip camera and sport dv
>> solutions.
>>
>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>> ---
>>  arch/arm/mach-hisi/Kconfig     | 9 +++++++++
>>  arch/arm/mach-hisi/hisilicon.c | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
>> index 83061ad..6bb822c 100644
>> --- a/arch/arm/mach-hisi/Kconfig
>> +++ b/arch/arm/mach-hisi/Kconfig
>> @@ -48,6 +48,15 @@ config ARCH_HIX5HD2
>>  	select PINCTRL_SINGLE
>>  	help
>>  	  Support for Hisilicon HIX5HD2 SoC family
>> +
>> +config ARCH_HI3519
> 
> Please keep these sorted alphabetically.

Sorry about that. I will correct it in next version.

> 
> Speaking of which, there is already an existing ARCH_HI3xxx entry.
> Should this be included in that family?   If not, maybe the HI3xxx
> should be renamed HI36xx ?

ARCH_HI3xxx just represents Hi36xx mobile soc family. Hi3519 is not included.
It's good advice to rename HI3xxx to HI36xx.

> Kevin
> 
> .
> 

Many thanks,

Jiacheng
