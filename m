From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 03 Mar 2014 18:28:28 -0800
Subject: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
In-Reply-To: <1393899715.20435.8.camel@joe-AO722>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org>	
 <1393899345-7397-2-git-send-email-graeme.gregory@linaro.org>
 <1393899715.20435.8.camel@joe-AO722>
Message-ID: <53153A4C.9050602@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2014 06:21 PM, Joe Perches wrote:
> On Tue, 2014-03-04 at 10:15 +0800, Graeme Gregory wrote:
>> Add maintainers for the arm-core file for arm64 ACPI support
> 
> Shouldn't something have to be in the kernel
> tree before there's a MAINTAINERS entry?

or in linux-next and the patch can be added to linux-next (some git tree).

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c6d0e93..c770d3a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -259,6 +259,13 @@ F:	drivers/pci/*/*acpi*
>>  F:	drivers/pci/*/*/*acpi*
>>  F:	tools/power/acpi
>>  
>> +ACPI ARM64
>> +M:	Hanjun Guo <hanjun.guo@linaro.org>
>> +M:	Graeme Gregory <graeme.gregory@linaro.org>
>> +S:	Supported
>> +L:	linux-acpi at vger.kernel.org
>> +F:	drivers/acpi/plat/arm-core.c
>> +
>>  ACPI COMPONENT ARCHITECTURE (ACPICA)
>>  M:	Robert Moore <robert.moore@intel.com>
>>  M:	Lv Zheng <lv.zheng@intel.com>


-- 
~Randy
