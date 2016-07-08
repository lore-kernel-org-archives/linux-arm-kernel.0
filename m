From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 Jul 2016 10:46:24 +0200
Subject: [RFC] [PATCH v3 1/4] spi: omap2-mcspi: Add comments for RX only
 DMA buffer workaround
In-Reply-To: <1467911871-4508-2-git-send-email-fcooper@ti.com>
References: <1467911871-4508-1-git-send-email-fcooper@ti.com>
 <1467911871-4508-2-git-send-email-fcooper@ti.com>
Message-ID: <20160708084624.GS6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 12:17:48PM -0500, Franklin S Cooper Jr wrote:
> OMAP35x and OMAP37x mentions in the McSPI End-of-Transfer Sequences section
> that if the McSPI is configured as a Master and only DMA RX is being
> performed then the DMA transfer size needs to be reduced by 1 or 2.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160708/992c6637/attachment.sig>
