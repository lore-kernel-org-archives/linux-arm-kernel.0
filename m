From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Sep 2014 14:57:38 +0100
Subject: [PATCH] regmap:change struct regmap's internal locks as union
In-Reply-To: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB01A@CNBJMBX05.corpusers.net>
Message-ID: <20140912135738.GX7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 04:19:49PM +0800, Wang, Yalin wrote:
> this patch change struct regmap->mutex and struct regmap->spinlock
> as an union, because these 2 members are only used one of them,
> we change it to shrink the struct size.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/da7860fd/attachment.sig>
