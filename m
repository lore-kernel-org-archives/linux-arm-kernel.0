From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 29 Jan 2018 14:01:59 -0500
Subject: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
In-Reply-To: <20180116214939.GC10860@bhelgaas-glaptop.roam.corp.google.com>
References: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
 <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org>
 <20180116214939.GC10860@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <fde756f4-eb74-4002-6ac4-a44405bad2da@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

On 1/16/2018 4:49 PM, Bjorn Helgaas wrote:
> On Tue, Jan 16, 2018 at 01:53:00PM -0500, Sinan Kaya wrote:
>> Correcting linux-pci email.
>>
>> On 1/16/2018 1:51 PM, Sinan Kaya wrote:
>>> When ACPI Link object is enabled, the message is printed with a warning
>>> prefix. Some test tools are capturing warning and test error types as
>>> errors. Let's reduce the verbosity of success case.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Looks like this was a result of 4d9391557b68 ("ACPI: add missing KERN_*
> constants to printks"), which I think added the wrong level in this case.
> 

Any chance of merging this for 4.16?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
