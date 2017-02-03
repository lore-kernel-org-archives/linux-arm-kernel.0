From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 3 Feb 2017 10:57:44 -0500
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <8687cb39-bffe-8f4a-76aa-a4d4ed61d30e@arm.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
 <fd106be9-836d-8d91-e57c-183ca56b4a49@arm.com>
 <45d4de34-cfd2-06af-93c2-e721bd80ab43@codeaurora.org>
 <8687cb39-bffe-8f4a-76aa-a4d4ed61d30e@arm.com>
Message-ID: <6eb61900-640d-fd7f-7e7f-9deced1ec71e@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/3/2017 10:49 AM, Marc Zyngier wrote:
>> Patches 13-15 are specific for MBIGEN. 00-12 are for the base functionality.
> Is that to support SMMUv3's own MSI generation? It would be helpful if
> you explained why you want this code to be merged beforehand,
> potentially without any in-tree user.

Sure, I'm more interested in supporting MSI on my HIDMA code rather than
MSI on SMMUv3.

HIDMA MSI patches were merged November 2016.

https://github.com/torvalds/linux/commits/master/drivers/dma/qcom/hidma.c

Commits on Nov 3, 2016
 @vinodkoul
dmaengine: qcom_hidma: add MSI support for interrupts  ?
Sinan Kaya committed with vinodkoul on Oct 21, 2016

I tested the first 12 patches of this series against HIDMA and provided
my tested-by.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
