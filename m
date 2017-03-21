From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 21 Mar 2017 19:38:29 +0000
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <c0f74140-f1f6-7c52-295a-5d4722017664@codeaurora.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <c0f74140-f1f6-7c52-295a-5d4722017664@codeaurora.org>
Message-ID: <8abb07bc-5660-6071-528f-7a810ad778d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/17 15:26, Sinan Kaya wrote:
> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
>> +	ats_enabled = !arm_smmu_enable_ats(master);
>> +
> 
> You should make ats_supported field in IORT table part of the decision
> process for when to enable ATS.
> 

Agreed. I will also draft a proposal for adding the ATS property to PCI
host controller DT bindings, it seems to be missing.

Thanks,
Jean-Philippe
