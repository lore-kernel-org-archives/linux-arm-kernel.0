From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Jul 2014 18:42:15 +0800
Subject: [PATCH 03/19] ARM64 / ACPI: Introduce lowlevel suspend function
In-Reply-To: <20140724153406.GC26190@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-4-git-send-email-hanjun.guo@linaro.org>
 <20140724153406.GC26190@leverpostej>
Message-ID: <53D23487.6090703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-24 23:34, Mark Rutland wrote:
[...]
>>  early_param("acpi", parse_acpi);
>> +
>> +/*
>> + * acpi_suspend_lowlevel() - save kernel state and suspend.
>> + *
>> + * TBD when ARM/ARM64 starts to support suspend...
>> + */
>> +int (*acpi_suspend_lowlevel)(void);
> 
> Shouldn't this should be intialised to NULL explicitly?

Yes, as ARM64 does not support suspend, initialize it
to NULL will be fine, will update in next version.

Thanks
Hanjun
