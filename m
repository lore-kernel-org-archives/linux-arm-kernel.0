From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Mon, 6 Oct 2014 19:21:53 +0100
Subject: [PATCH 1/4] ata: ahci_platform: Add ACPI support for AMD Seattle
 SATA controller
In-Reply-To: <2026795.jAP8HDLAZo@wuerfel>
References: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
 <4872185.h11DQxW6kP@wuerfel> <20141006163147.GA22482@srcf.ucam.org>
 <2026795.jAP8HDLAZo@wuerfel>
Message-ID: <20141006182153.GA31521@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 08:19:37PM +0200, Arnd Bergmann wrote:

> Interesting. Does this also define a way to get access to registers
> that are normally in PCI config space, provided they are accessible at
> all?

Unfortunately not. I'd assume that PM registers are expected to be 
accessed via the _PS* methods instead. Does MSI make sense outside the 
context of PCI interrupts?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
