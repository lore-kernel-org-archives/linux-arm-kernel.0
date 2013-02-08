From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Feb 2013 09:53:56 +0200
Subject: [PATCH V2 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings
 and nodes
In-Reply-To: <1360285506-22354-2-git-send-email-jon-hunter@ti.com>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
 <1360285506-22354-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20130208075356.GC21879@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 07:05:05PM -0600, Jon Hunter wrote:
> Add SDMA controller binding for OMAP2+ devices and populate DMA client
> information for SPI and MMC periperhal on OMAP3+ devices. Please note
> that OMAP24xx devices do not have SPI and MMC bindings available yet and
> so DMA client information is not populated.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

already given before, but here you go:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/5b822ef6/attachment.sig>
