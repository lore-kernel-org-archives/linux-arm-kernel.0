From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 8 Nov 2015 19:04:05 -0500
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <563F7418.4050203@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <563F7418.4050203@codeaurora.org>
Message-ID: <563FE2F5.3050802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/8/2015 11:11 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>> -#define ACPI_MAX_IRQS        256
>> +#define ACPI_MAX_IRQS        1020
>
> Why 1020?  Why not 1024?
>
1020 is the maximum interrupt ID that can be directed to an ARM SPI 
interrupt according to ARM architecture.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
