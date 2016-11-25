From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Nov 2016 13:05:40 +0000
Subject: [PATCH 1/5] spi: atmel: trivial: move info banner to latest
 probe action
In-Reply-To: <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre@atmel.com>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
 <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre@atmel.com>
Message-ID: <20161125130540.twmacpqtuzz6imdn@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 12:24:57PM +0100, Nicolas Ferre wrote:
> The info banner is here to tell that everything went well, so place
> it at the very end of the probe function.

Really we should just drop this, the banner is only telling us things
enumerated from DT so it's adding noise to the boot.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/7ef8494d/attachment.sig>
