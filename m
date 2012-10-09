From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 9 Oct 2012 05:57:22 +0000
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <20121008191657.GA3281@netboy.at.omicron.at>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com> <20121008191657.GA3281@netboy.at.omicron.at>
Message-ID: <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 00:46:57, Richard Cochran wrote:
> On Mon, Oct 01, 2012 at 12:27:17PM +0530, Vaibhav Hiremath wrote:
> 
> > I have just tested it to cross-check and it boots up fine with
> > linux-next/master branch. I have pasted boot log below for your reference.
> > 
> > 
> > 
> > U-Boot#
> > U-Boot# mmc rescan 0
> > U-Boot# fatload mmc 0 80000000 am335x-evm.dtb
> > reading am335x-evm.dtb
> 
> Two questions:
> 
> 1. Why are you using am335x-evm.dtb and not am335x-bone.dtb here?
> 

You can very well use bone dtb file, as of now we have very little in that 
which is specific to particular board.


> 2. Can you post your .config?
> 

I use omap2plus_defconfig + CONFIG_ARM_APPENDED_DTB + CONFIG_ARM_ATAG_DTB_COMPAT and nothing more.

Thanks,
Vaibhav
> Thanks,
> Richard
> 
