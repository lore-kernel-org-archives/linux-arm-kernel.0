From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 8 Oct 2015 08:44:15 -0700
Subject: [PATCH v4 0/5] PCI: generic: Misc. bug fixes/enhancements
In-Reply-To: <20151008152811.GD3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <20151008152811.GD3885@localhost>
Message-ID: <56168F4F.7030000@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2015 08:28 AM, Bjorn Helgaas wrote:
> On Fri, Oct 02, 2015 at 11:43:58AM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
[...]
>>
>> David Daney (5):
>>    PCI: Add pci_bus_fixup_irqs().
>>    PCI: generic: Only fixup irqs for bus we are creating.
>
> I'm hoping we won't need the above if we can resurrect Matthew's
> patches.

I will test some things with this today.


>
>>    PCI: generic: Quit clobbering our pci_ops.
>
> Applied to pci/host-generic for v4.4 with Arnd's Reviewed-by and minor
> changelog tweaks (as below).
>
>>    PCI: generic: Correct, and avoid overflow, in bus_max calculation.
>
> Seems not settled yet.
>
>>    PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
>
> Also applied to pci/host-generic, thanks!
>

Many thanks for getting those two in,


David Daney
