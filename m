From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 8 Oct 2012 21:16:57 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <50693ECD.4000000@ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com>
Message-ID: <20121008191657.GA3281@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 12:27:17PM +0530, Vaibhav Hiremath wrote:

> I have just tested it to cross-check and it boots up fine with
> linux-next/master branch. I have pasted boot log below for your reference.
> 
> 
> 
> U-Boot#
> U-Boot# mmc rescan 0
> U-Boot# fatload mmc 0 80000000 am335x-evm.dtb
> reading am335x-evm.dtb

Two questions:

1. Why are you using am335x-evm.dtb and not am335x-bone.dtb here?

2. Can you post your .config?

Thanks,
Richard
