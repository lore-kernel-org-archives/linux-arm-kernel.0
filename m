From: jcm@redhat.com (Jon Masters)
Date: Fri, 10 Jun 2016 19:50:43 -0400 (EDT)
Subject: [PATCH V9 00/11] Support for ARM64 ACPI based PCI host controller
In-Reply-To: <20160610234107.GC7671@localhost>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <20160610234107.GC7671@localhost>
Message-ID: <66887FB8-0D7E-42A0-AC25-A0BB8045D1B9@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you Bjorn :)

Next time we are in the same place (anyone involved in this series), beer is on me.

-- 
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 10, 2016, at 18:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> On Fri, Jun 10, 2016 at 09:55:08PM +0200, Tomasz Nowicki wrote:
>> From the functionality point of view this series may be split into the
>> following logic parts:
>> 1. Export ECAM API and add parent device to pci_config_window
>> 2. Add IO resources handling to PCI core code
>> 3. New MCFG driver
>> 4. Cleanups and support for generic domain assignment based on ACPI
>> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
> 
> This is beautiful!  It really turned out well.
> 
> I applied all these to pci/arm64-acpi for v4.8.
> 
> Bjorn
