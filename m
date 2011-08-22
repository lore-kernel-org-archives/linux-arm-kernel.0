From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Mon, 22 Aug 2011 16:21:38 +0200
Subject: plat-orion needs to enable PCIe ports for mv78xx0
In-Reply-To: <4E4C33D5.3050508@drewtech.com>
References: <4E4C33D5.3050508@drewtech.com>
Message-ID: <20110822142138.GK840@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 05:34:13PM -0400, Joey Oravec wrote:

> Orion maintainers,

Hello!


> On the Discovery series chips (mv78xx0), the CPU control and status
> register at offset 0x20104 contains bits to enable / disable PCI
> express port0 and port1. Both ports default to disabled.
> 
> It looks the PCIe driver and existing board setup files do not set
> this bit; any boards that use PCIe and are working today might
> assume that the bootloader has already set the bit to enable these
> ports.

Yep.


> I couldn't find anything in Marvell's documentation about timing,
> but the bits need to be set a long time before you touch any of the
> PCIe port registers.

I'll figure out.


thanks,
Lennert
