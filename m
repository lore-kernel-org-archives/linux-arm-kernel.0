From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 4 Nov 2014 16:32:03 +0100
Subject: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86 platforms
In-Reply-To: <5458ECF3.4040308@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <20141104144730.GE14512@8bytes.org>
 <5458ECF3.4040308@linux.intel.com>
Message-ID: <20141104153203.GE10744@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 11:12:51PM +0800, Jiang Liu wrote:
> 	Do you have the call stack? I have changed the way to call
> irq_set_msi_desc_off() for MSI/MSIx interrupts, which may cause the
> panic. Patch 19-21 changes the PCI MSI code.

Unfortunatly I have no full call-stack yet, as the intersting parts
scrolled out of the screen. But the last interesting function seen there
was do_one_initcall(). I'll try to setup serial console on the machine
and let you know when I have a full call-stack.


	Joerg
