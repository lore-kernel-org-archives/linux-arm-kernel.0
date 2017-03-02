From: kevin.tian@intel.com (Tian, Kevin)
Date: Thu, 2 Mar 2017 07:29:03 +0000
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
In-Reply-To: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C52DB1@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jean-Philippe Brucker
> Sent: Tuesday, February 28, 2017 3:55 AM
> 
[...]
> 
>   API naming
>   ==========
> 
> I realize that "SVM" as a name isn't great because the svm namespace is
> already taken by AMD-V (Secure Virtual Machine) in arch/x86. Also, the
> name itself doesn't say much.
> 
> I personally prefer "Unified Virtual Addressing" (UVA), adopted by CUDA,
> or rather Unified Virtual Address Space (UVAS). Another possibility is
> Unified Virtual Memory (UVM). Acronym UAS for Unified Address Space is
> already used by USB. Same for Shared Address Space (SAS), already in use
> in the kernel, but SVAS would work (although it doesn't look good).
> 

'unified' is not exactly matching to 'shared'. In some context it means
unifying device local memory and system memory in one virtual address
space, while SVM is more for sharing of a CPU virtual address space with 
device.

What about Shared Virtual Addressing (SVA)?

Thanks
Kevin
