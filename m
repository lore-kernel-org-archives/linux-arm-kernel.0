From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Jun 2017 22:29:20 -0600
Subject: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
In-Reply-To: <20170613041842.GA13308@kroah.com>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <20170613041842.GA13308@kroah.com>
Message-ID: <f6322f70-7ca7-abf6-b947-4cbbfd598948@deltatee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/17 10:18 PM, Greg Kroah-Hartman wrote:
> What test causes so many major numbers to be allocated?  Is this
> in-kernel test code?  Do you really have a system that requires so many
> different drivers that all want a dynamic char major?

This is a 0day kernel robot test. I'm not sure the motivations of its
design but it seems to be similar to an allyesconfig. So all/most
modules are compiled in and allocating their char device regions on boot
of a qemu instance.

Logan
