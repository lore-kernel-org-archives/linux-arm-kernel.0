From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Nov 2013 12:31:52 +0000
Subject: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <52644563.1000203@samsung.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <20131017102201.GK2443@sirena.org.uk>
 <52644563.1000203@samsung.com>
Message-ID: <20131120123152.GZ2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 06:04:35AM +0900, Kukjin Kim wrote:

> Applied this whole series.

This didn't seem to make it into -next or your tree, it'd be really
helpful to be able to merge into both ASoC and SPI so they can be used
for some framework work (I already have some patches for ASoC).  Would
it be possible to get the changes published on a separate branch or
signed tag so I can pull it into those subsystems for the next merge
window?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/374b91ea/attachment.sig>
