From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 16:25:51 +0100
Subject: [PATCH V2 2/8] ASoC: Samsung: I2S: Add quirks as driver data in
 I2S
In-Reply-To: <1417636.4d7IlsSAyI@amdc1227>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-3-git-send-email-padma.v@samsung.com>
 <20130726145319.GI9858@sirena.org.uk> <1417636.4d7IlsSAyI@amdc1227>
Message-ID: <20130726152551.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 05:02:46PM +0200, Tomasz Figa wrote:

> IMHO this SoC-based identification looks much better, especially considering 
> the fact that IP version isn't something easily determinable, as even the 
> documentation can sometimes be not really clear about that.

Yeah, it's not terribly clever either way.  We've been using the version
numbers in audio for a long time partly because it is documented
sometimes and partly because most of the SoCs tend to have one fully
featured controller and a bunch of secondary controllers on older IP
revisions.

> However the s3c6410-i2sv4 string looks a bit unfortunate. AFAIK there were 
> two types of I2S IPs on S3C6410 - normal I2S and I2S multichannel. What 
> about having a compatible like s3c6410-i2s-multi?

It was explicitly identified as I2Sv4 in the S3C6410 datasheet so no
real issue there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/0034ce34/attachment.sig>
