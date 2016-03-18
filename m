From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2016 16:22:35 +0000
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318165203.4512ed1d@free-electrons.com>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <87oaab980n.fsf@free-electrons.com>
 <20160318144639.GH19428@n2100.arm.linux.org.uk>
 <20160318163518.122505a5@free-electrons.com>
 <20160318154500.GJ19428@n2100.arm.linux.org.uk>
 <20160318165203.4512ed1d@free-electrons.com>
Message-ID: <20160318162235.GK19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 04:52:03PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 18 Mar 2016 15:45:00 +0000, Russell King - ARM Linux wrote:
> 
> > I do seem to be carrying some patches for some time for CESA:
> > 
> > crypto: marvell: rearrange handling for sw padded hashes
> > crypto: marvell: rearrange handling for hw finished hashes
> > crypto: marvell: rearrange last request handling
> > crypto: marvell: avoid adding final operation within loop
> > crypto: marvell: ensure iter.base.op_len is the full op length
> > crypto: marvell: use presence of scatterlist to determine data load
> > crypto: marvell: move mv_cesa_dma_add_frag() calls
> > crypto: marvell: always ensure mid-fragments after first-fragment
> > crypto: marvell: factor out adding an operation and launching it
> > crypto: marvell: factor out first fragment decisions to helper
> > crypto: marvell: const-ify argument to mv_cesa_get_op_cfg()
> > crypto: marvell: ensure template operation is initialised
> > crypto: marvell: fix the bit length endianness
> > crypto: marvell: add flag to determine algorithm endianness
> > crypto: marvell: keep creq->state in CPU endian format at all times
> > crypto: marvell: easier way to get the transform
> > 
> > and the last time I seem to have any comments on them was back in
> > October last year.  I don't remember what status these are, and as I've
> > been concentrating on other areas.  I'll try to remember to send them
> > out after rc1.
> 
> All (or most) of these patches seem to be in mainline already:

Thanks for confirming... in which case it's not the marvell cesa patches
but the fsl/nxp caam patches that are still pending... those definitely
aren't part of 4.5.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
