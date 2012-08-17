From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 17 Aug 2012 13:09:31 +0300
Subject: [PATCH] ARM: LPC32xx: Provide DMA filter callbacks via platform
 data
In-Reply-To: <1345122935-22115-1-git-send-email-stigge@antcom.de>
References: <1345122935-22115-1-git-send-email-stigge@antcom.de>
Message-ID: <1345198171.27859.39.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-08-16 at 15:15 +0200, Roland Stigge wrote:
> The SLC and MLC NAND drivers now need their dma_filter callbacks via platform
> data to make them independent of single DMA engine drivers.
> 
> (This also helps fixing build errors of the SLC and MLC drivers when building
> as modules because direct access to AMBA dma filter functions isn't available
> via export.)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Pushed the 3 patches to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/c68f8b7a/attachment.sig>
