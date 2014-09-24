From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Sep 2014 09:32:05 +0100
Subject: [PATCH v2] spi: pl022: Add support for chip select extension
In-Reply-To: <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
References: <20140916183431.GX7960@sirena.org.uk>
 <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
Message-ID: <20140924083205.GZ4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 08:46:58AM +0200, Anders Berg wrote:
> Add support for a extended PL022 which has an extra register for controlling up
> to five chip select signals. This controller is found on the AXM5516 SoC.
> Unfortunately the PrimeCell identification registers are identical to a
> standard ARM PL022. To work around this, the peripheral ID must be overridden
> in the device tree using the "arm,primecell-periphid" property with the value
> 0x000b6022.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/18a31d15/attachment.sig>
