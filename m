From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Jun 2013 11:28:18 +0100
Subject: [RFC PATCH v2 00/12] ARM: s3c64xx: Let amba-pl08x driver handle
 DMA
In-Reply-To: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130625102818.GA27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42:32PM +0200, Tomasz Figa wrote:
> This is another version of my patches extending support of amba-pl08x
> DMA engine driver to PL080S DMA engine (PL080 modified by Samsung) found
> in Samsung S3C64xx SoCs.

On my non-DT s3c64xx system I get this when trying to use SPI for the
first time:

[    1.739385] s3c64xx-spi s3c6410-spi.0: Failed to get RX DMA channel
[    1.743437] spi_master spi0: failed to prepare transfer hardware

though I haven't yet tried your clock patches (there were some conficts
that I didn't get round to picking up yet).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/20334507/attachment.sig>
