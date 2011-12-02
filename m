From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Dec 2011 17:52:51 -0500 (EST)
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDB0539@HQMAIL01.nvidia.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
 <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
 <20111201111049.GB2915@opensource.wolfsonmicro.com>
 <20111201121403.GC2026@localhost.localdomain>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB01C6@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB0539@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.02.1112021739420.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Dec 2011, Stephen Warren wrote:

> For the record, the changes are now in U-Boot master:
> 
> d510859 image: Don't detect XIP images as overlapping.
> b9b50e8 image: Implement IH_TYPE_KERNEL_NOLOAD

Yay!  Thank you Stephen for driving this to a successful resolution.

Of course, boards won't be updated to the latest u-boot right away, nor 
will the enhanced mkimage tool be commonly available.

> I should also note that Marek Vasut posted some patches to implement a
> bootz command in U-Boot. This turned out to be much less invasive than
> I originally thought, so once those patches are finalized, uImage might
> be irrelevant except for initrds (U-Boot already accepts a raw FDT
> without uImage wrapping for bootm and hence bootz).
> 
> http://www.mail-archive.com/u-boot at lists.denx.de/msg69287.html

Excellent!


Nicolas
