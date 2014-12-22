From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Dec 2014 14:00:15 +0000
Subject: [PATCH v3 3/5] ASoC: dwc: Reorder code in preparation for DT
 support
In-Reply-To: <cc0f212c245beaefa542194cabe5cf5ebfc81fd3.1418826016.git.Andrew.Jackson@arm.com>
References: <cover.1418826016.git.Andrew.Jackson@arm.com>
 <cc0f212c245beaefa542194cabe5cf5ebfc81fd3.1418826016.git.Andrew.Jackson@arm.com>
Message-ID: <20141222140015.GR17800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 04:18:07PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> Move code that configures the DAI and DMA into a separate function.  This
> reduces the size of the dw_i2s_probe function and will make it easier to
> add support for device tree to the driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141222/c92b5f8c/attachment.sig>
