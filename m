From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 4 Dec 2015 14:46:19 -0600
Subject: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
In-Reply-To: <5018756.5lEEeJVMod@wuerfel>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <1449155999-220955-2-git-send-email-gabriele.paoloni@huawei.com>
 <20151203175826.GB2935@red-moon> <5018756.5lEEeJVMod@wuerfel>
Message-ID: <5661FB9B.20201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 02:58 PM, Arnd Bergmann wrote:
> On Thursday 03 December 2015 17:58:26 Lorenzo Pieralisi wrote:
>> I will put together a proposal to define the way we specify HID and
>> related DSD properties for PCI host controllers and send it to
>> the ACPI working group for review.
>
> That also requires a change to SBSA, right? Today, SBSA assumes that
> we have a standard PCI host that will work with any hardware independent
> PCI implementation in an OS. We either have to give up on SBSA saying
> much about how PCI hosts are implemented, or stop assuming that hardware
> is SBSA compliant.

Which would be standardizing nonstandard hardware. It would surprise me 
if that got much traction.
