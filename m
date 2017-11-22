From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 09:05:08 -0500
Subject: [PATCH 23/30] [media] atomisp: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511353247.3539.10.camel@linux.intel.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-24-git-send-email-okaya@codeaurora.org>
 <1511353247.3539.10.camel@linux.intel.com>
Message-ID: <b87604f8-07f5-5cdc-b022-286c17ea66eb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On 11/22/2017 7:20 AM, Alan Cox wrote:
> On Wed, 2017-11-22 at 00:31 -0500, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0
>> as
>> where a PCI device is present. This restricts the device drivers to
>> be
>> reused for other domain numbers.
> 
> The ISP v2 will always been in domain 0.
> 

Sorry, I didn't get what you mean. Do you mean that you are OK with the
change (thus, can I get a reviewed by) or do you mean that I should fix
the commit message?

I wrote a generic commit message and applied it to all 30 patches that
are more or less similar. I can certainly tailor the message a little
bit for atomisp since you confirmed domain 0.

> Alan
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
