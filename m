From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 May 2016 16:06:29 +0100
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <3620725.8soc3SaFWB@vostro.rjw.lan>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
 <3620725.8soc3SaFWB@vostro.rjw.lan>
Message-ID: <57334A75.10207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/16 01:07, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2016 01:30:12 PM Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> It also selects ARCH_SUPPORTS_ACPI_PROCESSOR_LPI if ACPI is enabled
>> on ARM64.
>
> Can you remind me why we need the ARCH_SUPPORTS_ACPI_PROCESSOR_LPI thing in
> addition to the previously defined ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE?
>

That's stupid of me, I removed it from the driver in v4 but the few
remnants of it stayed by mistake(mainly in this patch alone)

> I thought supporting LPI would not require an arch Kconfig option.
>

That's correct.

-- 
Regards,
Sudeep
