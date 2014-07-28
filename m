From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 22:30:53 +0100
Subject: [PATCH 1/2] spi: orion: fix incorrect handling of cell-index DT
 property
In-Reply-To: <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140728213053.GH17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 27, 2014 at 11:53:19PM +0200, Thomas Petazzoni wrote:
> In commit f814f9ac5a81 ("spi/orion: add device tree binding"), Device
> Tree support was added to the spi-orion driver. However, this commit
> reads the "cell-index" property, without taking into account the fact
> that DT properties are big-endian encoded.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/2c1dd110/attachment.sig>
