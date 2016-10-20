From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 20 Oct 2016 23:08:08 +0200
Subject: [PATCH V3 1/3] ACPI,
 PCI IRQ: add PCI_USING penalty for ISA interrupts
In-Reply-To: <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
 <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost>
 <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
Message-ID: <CAJZ5v0gZmNxOF5hf8oYF_UYUNHrYkFy=Y7SWGCZ+VRKGNeJmcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 10:01 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 10/19/2016 3:44 PM, Bjorn Helgaas wrote:

[cut]

> If we want to move the ISA pieces out of this file, that can be done too.
> We can also add support for PNPACPI. I'm not a very big fan of scratch
> everything and start from beginning approach. This refactoring effort already
> failed 3 times. I'd like to close the issue and move on.

Understood, but we have broken this for too many times already.

Either we have a minimum fix that is known working or we are going back.

Thanks,
Rafael
