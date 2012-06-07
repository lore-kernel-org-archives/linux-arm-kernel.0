From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 07 Jun 2012 15:49:35 +0300
Subject: [CFT 09/11] mtd: omap2: add DMA engine support
In-Reply-To: <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
 <E1Scaaa-0003uB-1l@rmk-PC.arm.linux.org.uk>
Message-ID: <1339073375.6875.102.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 12:09 +0100, Russell King wrote:
> Add DMA engine support to the OMAP2 NAND driver.  This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be independently switched at build time between using DMA
> engine and the private DMA API.
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I guess it is makes sense to make this stuff to go in via the OMAP tree.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/2a85a927/attachment.sig>
