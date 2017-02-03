From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 3 Feb 2017 09:50:26 -0500
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Message-ID: <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/18/2017 7:54 AM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> With platform msi support landed in the kernel, and the introduction
> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
> is ready, this patch set add few patches to enable the ACPI platform
> msi support.
> 
> For platform device connecting to ITS on arm platform, we have IORT
> table with the named componant node to describe the mappings of paltform
> device and ITS, so we can retrieve the dev id and find its parent
> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
> 

I understand that there is a consensus on IORT/SMMUv3 specific pieces
of this series while there is some ongoing work on the MBIgen part in
due to dependency on Agustin's patch vs. ACPI definitions.

Can we merge the IORT/SMMUv3 specific pieces to 4.11 so that the base
implementation comes in place?

Any objections to not doing so?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
