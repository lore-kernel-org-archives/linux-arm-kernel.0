From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 19 Apr 2018 18:19:32 -0400
Subject: [PATCH 1/2] IB/hfi1: Try slot reset before secondary bus reset
In-Reply-To: <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
References: <1524167784-5911-1-git-send-email-okaya@codeaurora.org>
 <20180419202632.GE14063@ziepe.ca>
 <20180419214722.GO28657@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <290e9530-dcde-9c10-7ae0-59ac4c509db4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2018 5:47 PM, Bjorn Helgaas wrote:
>> Bjorn, would be appropriate to export pci_parent_bus_reset() or some
>> variation therin??
> I agree it would be really nice if the PCI core could help out somehow
> so we could get some of this code out of individual drivers.

I can create a function called pci_reset_link() and move both slot and
secondary bus reset inside. 

Will this work?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
