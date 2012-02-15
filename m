From: bill4carson@gmail.com (bill4carson)
Date: Wed, 15 Feb 2012 10:50:23 +0800
Subject: [PATCH 6/7] Add hugetlb Kconfig option
In-Reply-To: <4F38ED34.1030300@ru.mvista.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-7-git-send-email-bill4carson@gmail.com>
 <4F38ED34.1030300@ru.mvista.com>
Message-ID: <4F3B1D6F.8080409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?02?13? 19:00, Sergei Shtylyov wrote:
> Hello.
>
> On 13-02-2012 13:44, Bill Carson wrote:
>
>> Signed-off-by: Bill Carson<bill4carson@gmail.com>
>> ---
>> arch/arm/Kconfig | 29 +++++++++++++++++++++++++++++
>> 1 files changed, 29 insertions(+), 0 deletions(-)
>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a48aecc..161bca6 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -985,6 +985,35 @@ config ARCH_ZYNQ
>> Support for Xilinx Zynq ARM Cortex A9 Platform
>> endchoice
>>
>> +config SYS_SUPPORTS_HUGETLBFS
>> + def_bool n
>
> This is probably overindented.
>
Hi, Sergei

Thanks for your point :)

I'm sure there are other coding style issues like this, I'll pay
attention to it in the next review round.




> WBR, Sergei
>

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
