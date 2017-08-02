From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 2 Aug 2017 13:21:05 -0400
Subject: [PATCH V6 2/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1501694304-16554-2-git-send-email-okaya@codeaurora.org>
References: <1501694304-16554-1-git-send-email-okaya@codeaurora.org>
 <1501694304-16554-2-git-send-email-okaya@codeaurora.org>
Message-ID: <16687e3e-a91b-658f-4c87-43bea46f3240@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/2/2017 1:18 PM, Sinan Kaya wrote:
> pci_flr_wait() will keep
> calling this function 60 times to allow up to 60 seconds to be consistent
> with the rest of the kernel CRS timeout handling.

I forgot to update the commit message. I'll wait until Bjorn/Alex reviews this
version.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
