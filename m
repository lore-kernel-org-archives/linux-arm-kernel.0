From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 3 Dec 2011 00:03:19 +0100
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <alpine.LFD.2.02.1112021739420.2357@xanadu.home>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDB0539@HQMAIL01.nvidia.com>
 <alpine.LFD.2.02.1112021739420.2357@xanadu.home>
Message-ID: <201112030003.20003.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, 2 Dec 2011, Stephen Warren wrote:
> > For the record, the changes are now in U-Boot master:
> > 
> > d510859 image: Don't detect XIP images as overlapping.
> > b9b50e8 image: Implement IH_TYPE_KERNEL_NOLOAD
> 
> Yay!  Thank you Stephen for driving this to a successful resolution.
> 
> Of course, boards won't be updated to the latest u-boot right away

Though we should demand it on the new boards at least.

> , nor
> will the enhanced mkimage tool be commonly available.

Why not, just tell people to use up-to-date tools, otherwise you can't support 
them. It's really easy.

> 
> > I should also note that Marek Vasut posted some patches to implement a
> > bootz command in U-Boot. This turned out to be much less invasive than
> > I originally thought, so once those patches are finalized, uImage might
> > be irrelevant except for initrds (U-Boot already accepts a raw FDT
> > without uImage wrapping for bootm and hence bootz).
> > 
> > http://www.mail-archive.com/u-boot at lists.denx.de/msg69287.html
> 
> Excellent!
> 
Nico, please see my other mail. This is really going to 2012.03 release 
earliest. 2011.12 release is definitelly missed, sorry.

> 
> Nicolas

M
