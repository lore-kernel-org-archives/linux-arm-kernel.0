From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 11:56:53 +0100
Subject: [PATCH] ASoC: simple-card: fix regression in clock rate lookup
In-Reply-To: <42811667.3TM1iBfezH@wuerfel>
References: <42811667.3TM1iBfezH@wuerfel>
Message-ID: <20140910105653.GB7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 01:14:05PM +0200, Arnd Bergmann wrote:
> Commit 7c7b9cf53d284f ("ASoC: simple-card: fixup cpu_dai_name
> clear case") changed the way that "sound-dai" properties are handled,
> which leads to the clock frequency not being picked up from the
> node that the phandle points to, as correctly identified by gcc
> with this warning:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/5368762a/attachment-0001.sig>
