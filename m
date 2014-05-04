From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 04 May 2014 16:58:12 +0800
Subject: [PATCH v3 part1 02/11] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
In-Reply-To: <20140429093941.02167C4095B@trevor.secretlab.ca>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>	<1398432017-8506-3-git-send-email-hanjun.guo@linaro.org>
 <20140429093941.02167C4095B@trevor.secretlab.ca>
Message-ID: <53660124.6020604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-4-29 17:39, Grant Likely wrote:
> On Fri, 25 Apr 2014 21:20:08 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> The _PDC (Processor Driver Capabilities) object provides OSPM a
>> mechanism to convey to the platform the capabilities supported
>> by OSPM for processor power management.
>>
>> OSPM evaluates _PDC prior to evaluating any other processor
>> power management objects returning configuration information.
>>
>> This patch introduces the skeleton of _PDC related file to make
>> ACPI core can be compiled on ARM64, and should be revisited when
>> implementing CPU power control.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h |   37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/acpi.h
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> new file mode 100644
>> index 0000000..e3e990e
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -0,0 +1,37 @@
>> +/*
>> + *  Copyright (C) 2013~2014, Al Stone <al.stone@linaro.org>
> 
> Not really a correct copyright assignement. The copyright is held by
> Linaro, but the author is Al. It should instead read:
> 
>  * Copyright (C0 2013-2014, Linaro Ltd.
>  * Author: Al Stone <al.stone@linaro.org>
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>

We will update this patch accordingly.

Thanks
Hanjun
