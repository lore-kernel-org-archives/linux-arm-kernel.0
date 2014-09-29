From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Sep 2014 17:12:17 +0100
Subject: [PATCH] ASoC: davinci: vcif must be a module if SND_DAVINCI_SOC is
In-Reply-To: <2771900.ce8bYznKIN@wuerfel>
References: <2771900.ce8bYznKIN@wuerfel>
Message-ID: <20140929161217.GT16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 05:32:17PM +0200, Arnd Bergmann wrote:
> It is possible to configure a kernel with SND_DAVINCI_SOC=m and
> SND_DM365_VOICE_CODEC=y, which results in a link error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/5ca46ad9/attachment.sig>
