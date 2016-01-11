From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 11 Jan 2016 14:28:18 +0530
Subject: dra7xx pci driver broken on dra7xx-evm
In-Reply-To: <20160108092249.GC2344@localhost.localdomain>
References: <20160106214518.GA6106@localhost.localdomain>
 <568DF4FE.5010704@ti.com> <568ED7FA.4000508@ti.com>
 <20160107215946.GP12777@atomide.com> <568F520D.9050807@ti.com>
 <20160108092249.GC2344@localhost.localdomain>
Message-ID: <56936EAA.1040203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 08 January 2016 02:52 PM, Richard Cochran wrote:
> On Fri, Jan 08, 2016 at 11:37:09AM +0530, Kishon Vijay Abraham I wrote:
>> All right. I'll post the patch to do reset using platform data.
> 
> Thanks for taking care of this.
> 
> BTW, I am trying to get a new board working.  Are there any *other*
> dra7xx peripherals I should know about, or is the mainline stuff all
> working?

Nothing that I'm aware of. I've tested Ethernet, USB, SATA, MMC and PCIe (with
reset changes) myself. PCI was the only device that needed out of tree patches.

Thanks
Kishon
