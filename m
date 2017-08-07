From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Aug 2017 12:20:30 +0100
Subject: [PATCH] ASoC: pxa: don't select SSP for COMPILE_TESTing
In-Reply-To: <20170807104101.3540159-1-arnd@arndb.de>
References: <20170807104101.3540159-1-arnd@arndb.de>
Message-ID: <20170807112030.zvz3flujilsixdj4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 12:40:44PM +0200, Arnd Bergmann wrote:
> When the audio driver selects CONFIG_PXA_SSP to be a loadable
> module on a platform other than PXA, and the PXA SPI driver
> is built-in, we get a link error in the SPI driver:

Why doesn't this cause problems on PXA?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/855a6a24/attachment.sig>
