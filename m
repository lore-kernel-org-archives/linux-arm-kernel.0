From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 24 Oct 2016 00:17:29 -0400
Subject: [V4, 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during early
 boot stages
In-Reply-To: <CANwerB0UzXPL3a4wu=0XfUtzBw93qdurSaMcYBOvxEyiCjLh6Q@mail.gmail.com>
References: <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
 <CANwerB0UzXPL3a4wu=0XfUtzBw93qdurSaMcYBOvxEyiCjLh6Q@mail.gmail.com>
Message-ID: <fae460e4-d838-22c0-8984-52d6d2b6c099@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks,

On 10/22/2016 11:48 PM, Jonathan Liu wrote:
> This series fixes one or more network adapters not working in Linux
> 32-bit x86 guest running inside VirtualBox if I have 4 network
> adapters enabled. The following message no longer appears in the
> kernel log:
> ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off
> 
> Tested-by: Jonathan Liu <net147@gmail.com>

I'm hoping that you can retest V5 so that Rafael can pull in your tested-by into
the commit message.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
