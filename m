From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 8 Mar 2017 10:26:50 -0500
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Message-ID: <c0f74140-f1f6-7c52-295a-5d4722017664@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
> +	ats_enabled = !arm_smmu_enable_ats(master);
> +

You should make ats_supported field in IORT table part of the decision
process for when to enable ATS.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
