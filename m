From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Jun 2014 14:36:06 +0100
Subject: [PATCH 1/2] [RFC] ASoC: samsung: move s3c24xx over to dmaengine
In-Reply-To: <6123933.aGtaUr149J@wuerfel>
References: <6123933.aGtaUr149J@wuerfel>
Message-ID: <20140605133606.GX2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 03:20:50PM +0200, Arnd Bergmann wrote:
> The s3c24xx sound support keeps giving randconfig build errors, this
> is a new attempt to solve it by moving the driver over to use dmaengine
> exclusively.

We already have a patch pending for this, it's just waiting until after
the merge window to avoid bisection breakage since it depends on
dmaengine changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140605/1dace5ed/attachment.sig>
