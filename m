From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Dec 2012 17:09:37 +0000
Subject: [PATCH V5 2/2] ASoC: SAMSUNG: Add DT support for i2s
In-Reply-To: <20121219132414.2CF653E0AD7@localhost>
References: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
 <1355395373-22058-3-git-send-email-padma.v@samsung.com>
 <20121219132414.2CF653E0AD7@localhost>
Message-ID: <20121219170937.GV4985@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 01:24:14PM +0000, Grant Likely wrote:
> On Thu, 13 Dec 2012 16:12:53 +0530, Padmavathi Venna <padma.v@samsung.com> wrote:

> > +- compatible : "samsung,samsung-i2s"

> Isn't that kind of redundant?  :-)

> The format of the compatible strings should be "<vendor>,<part-number>-i2s". 
> Please be specific about the part number that you're doing the binding
> for. For example; use "samsung,exynos4210-i2s" instead of "samsung,exynos-i2s".

There are actually versioned IPs here (where the versions are used
publically in a few places) but it's not clearly documented which is
which.  It would be reasonable to use the IP versions here I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121219/840a7bdc/attachment.sig>
