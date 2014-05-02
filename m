From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 May 2014 10:26:43 -0700
Subject: [PATCH 13/15] ASoC: SND_S3C_DMA_LEGACY needs S3C24XX_DMA
In-Reply-To: <11471248.qyIXLf6t3H@diego>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <20140501191125.GB3245@sirena.org.uk> <7071653.m3UbztQEJc@wuerfel>
 <11471248.qyIXLf6t3H@diego>
Message-ID: <20140502172643.GU3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 12:25:58PM +0200, Heiko St?bner wrote:

> Mark already removed support for the legacy API from the s3c64xx spi driver 
> (used by s3c2416 and s3c2443), so I guess to way forward would be to "simply" 
> convert asoc and s3cmci to dmaengine and get rid of it altogether.

ASoC is already totally capable of using dmaengine on Samsung platforms,
we're just wating for the architecture to be converted.  I know there's
a dmaengine driver present but it needs to actually be used on the
platforms, there should be no blocker on that from the ASoC side.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/3d4cd536/attachment.sig>
