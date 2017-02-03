From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 3 Feb 2017 15:11:41 +0000
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
Message-ID: <fd106be9-836d-8d91-e57c-183ca56b4a49@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/17 14:50, Sinan Kaya wrote:
> On 1/18/2017 7:54 AM, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> With platform msi support landed in the kernel, and the introduction
>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>> is ready, this patch set add few patches to enable the ACPI platform
>> msi support.
>>
>> For platform device connecting to ITS on arm platform, we have IORT
>> table with the named componant node to describe the mappings of paltform
>> device and ITS, so we can retrieve the dev id and find its parent
>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>
> 
> I understand that there is a consensus on IORT/SMMUv3 specific pieces
> of this series while there is some ongoing work on the MBIgen part in
> due to dependency on Agustin's patch vs. ACPI definitions.
> 
> Can we merge the IORT/SMMUv3 specific pieces to 4.11 so that the base
> implementation comes in place?

Sorry, but I may be missing something. Which IORT/SMMUv3 patches are we
talking about? Do you have a pointer to a series?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
