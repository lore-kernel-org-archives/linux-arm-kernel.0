From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 07 Jun 2012 16:28:03 +0300
Subject: [CFT 09/11] mtd: omap2: add DMA engine support
In-Reply-To: <20120607131158.GC15973@n2100.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
 <1339073375.6875.102.camel@sauron.fi.intel.com>
 <20120607131158.GC15973@n2100.arm.linux.org.uk>
Message-ID: <1339075683.6875.109.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 14:11 +0100, Russell King - ARM Linux wrote:
> No, it makes sense to get this stuff via a single tree all together,
> because, as you can see from the thread structure, it isn't purely
> an OMAP thing.
> 
> The OMAP stuff depends on a core set, as does a bunch of PL08x and
> SA11x0 changes.  We can't stuff all that through the OMAP tree, that
> wouldn't make any sense.
> 
> What probably should happen is that the tip of the OMAP stuff gets
> pulled by Tony into his tree, and we share those commits between my
> tree and his - and then it doesn't matter what goes in when and by
> whom.

Oh, sure, sorry, I actually wanted to say that these to patches should
_not_ got via the MTD tree.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/e70089bd/attachment.sig>
