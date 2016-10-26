From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 26 Oct 2016 14:34:29 -0400
Subject: [PATCH V5 3/3] ACPI: pci_link: Include PIRQ_PENALTY_PCI_USING for
 ISA IRQs
In-Reply-To: <CANwerB2KywvUKAv84kvoyAV2YkqtOL9LbFOqSTLgZ=dCk-Z5xA@mail.gmail.com>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
 <1477283492-26657-4-git-send-email-okaya@codeaurora.org>
 <CANwerB2KywvUKAv84kvoyAV2YkqtOL9LbFOqSTLgZ=dCk-Z5xA@mail.gmail.com>
Message-ID: <e08e67d2-4f4f-4063-a561-339d6a5bf7ca@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Jonathan,

On 10/24/2016 12:46 AM, Jonathan Liu wrote:
>> 1.9.1
>> >
> This series fixes one or more network adapters not working in Linux
> 32-bit x86 guest running inside VirtualBox if I have 4 network
> adapters enabled.
> The following message no longer appears in the kernel log:
> ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
> 
> Tested-by: Jonathan Liu <net147@gmail.com>

Can we also get some more testing coverage from the people in TO?

We want to make sure that we fixed all outstanding ACPI PCI IRQ issues.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
