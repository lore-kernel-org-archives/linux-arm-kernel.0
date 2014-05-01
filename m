From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 18:23:59 -0700
Subject: [PATCH] ASoC: cq93vc: fix cq93vc_get_regmap build error
In-Reply-To: <4308079.So6q7GrfYB@wuerfel>
References: <4308079.So6q7GrfYB@wuerfel>
Message-ID: <20140501012359.GH3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 11:06:29AM +0200, Arnd Bergmann wrote:
> 49101a25acd69c "ASoC: cq93vc: Remove the set_cache_io() entirely from
> ASoC probe" introduced the cq93vc_get_regmap function that has an
> obvious build error referring to the 'codec' variable that is not
> declared anywhere"

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/1eea7104/attachment.sig>
