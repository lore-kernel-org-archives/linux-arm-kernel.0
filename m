From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Dec 2015 22:34:31 +0100
Subject: [RFC PATCH 1/2] PCI/ACPI: Add ACPI support for non ECAM Host
 Bridge Controllers
In-Reply-To: <5661FB9B.20201@arm.com>
References: <1449155999-220955-1-git-send-email-gabriele.paoloni@huawei.com>
 <5018756.5lEEeJVMod@wuerfel> <5661FB9B.20201@arm.com>
Message-ID: <2425021.SWJx48r3Ls@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 December 2015 14:46:19 Jeremy Linton wrote:
> On 12/03/2015 02:58 PM, Arnd Bergmann wrote:
> > On Thursday 03 December 2015 17:58:26 Lorenzo Pieralisi wrote:
> >> I will put together a proposal to define the way we specify HID and
> >> related DSD properties for PCI host controllers and send it to
> >> the ACPI working group for review.
> >
> > That also requires a change to SBSA, right? Today, SBSA assumes that
> > we have a standard PCI host that will work with any hardware independent
> > PCI implementation in an OS. We either have to give up on SBSA saying
> > much about how PCI hosts are implemented, or stop assuming that hardware
> > is SBSA compliant.
> 
> Which would be standardizing nonstandard hardware. It would surprise me 
> if that got much traction.

What do you suggest instead?

	Arnd
