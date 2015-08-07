From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Aug 2015 14:16:27 +0100
Subject: [PATCH v2] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
In-Reply-To: <op.x2yr7kbcltbbtz@localhost>
References: <op.x2pmc5kiltbbtz@localhost>
 <20150804171931.GZ20873@sirena.org.uk>
 <op.x2yr7kbcltbbtz@localhost>
Message-ID: <20150807131627.GB10301@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 10:51:10PM +0200, Hermann Kraus wrote:
> Use requested bit rate instead of maximum possible and correctly calculate
> the divider.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150807/d45010eb/attachment.sig>
