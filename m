From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 16:30:59 +0000
Subject: [PATCH 2/4] spi: st: Provide Device Tree binding documentation
In-Reply-To: <20141127145542.GH4628@x1>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-3-git-send-email-lee.jones@linaro.org>
 <20141127130053.GW7712@sirena.org.uk> <20141127145542.GH4628@x1>
Message-ID: <20141127163059.GZ7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 02:55:42PM +0000, Lee Jones wrote:
> On Thu, 27 Nov 2014, Mark Brown wrote:

> > What do the two different compatible strings mean (for example, should
> > ssc4 be used for version 4 and higher or is it just a quirk for that
> > version)?

> This appears to be historical.  There aren't any functional
> differences i.e. we don't match on them.  I believe the former is a
> more informal, generic name and the latter is the official name of the
> IP block.  The I2C component already upstreamed has the same naming
> conventions by the looks of it.

Probably best to say something or retire one then.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/eb94ebc5/attachment.sig>
