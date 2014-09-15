From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 16 Sep 2014 06:55:49 +0800
Subject: [PATCH v4 06/18] ARM64 / ACPI: Introduce early_param for "acpi"
In-Reply-To: <20140915062824.GB26649@localhost>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-7-git-send-email-hanjun.guo@linaro.org>
 <20140915062824.GB26649@localhost>
Message-ID: <54176E75.1000803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?09?15? 14:28, Olof Johansson wrote:
> On Fri, Sep 12, 2014 at 10:00:04PM +0800, Hanjun Guo wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> Introduce one early parameters "off" for "acpi" to disable ACPI on
>> ARM64.
>>
>> This ensures the kernel uses the DT on a platform that provides both
>> ACPI tables and DT.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  Documentation/kernel-parameters.txt |    3 ++-
>>  arch/arm64/kernel/acpi.c            |   15 +++++++++++++++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>> index 5ae8608..9dfb1d8 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -165,7 +165,7 @@ multipliers 'Kilo', 'Mega', and 'Giga', equalling 2^10, 2^20, and 2^30
>>  bytes respectively. Such letter suffixes can also be entirely omitted.
>>  
>>  
>> -	acpi=		[HW,ACPI,X86]
>> +	acpi=		[HW,ACPI,X86,ARM]
> ARM64, not ARM.

I will update it.

Thanks
Hanjun
