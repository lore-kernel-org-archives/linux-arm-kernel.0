From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Jan 2015 11:51:37 +0000
Subject: [PATCH] ASoC: davinci: fix DM365_EVM codec selection
In-Reply-To: <12284641.mhX5PHEsR2@wuerfel>
References: <12284641.mhX5PHEsR2@wuerfel>
Message-ID: <20150129115137.GD21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:30:01PM +0100, Arnd Bergmann wrote:
> An earlier bug fix of mine made the SND_DM365_VOICE_CODEC symbol
> tristate to avoid creating an undefined reference from the
> davinci-vcif.c driver to the davinci_soc_platform_register
> function that may be in a module.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/3273ba33/attachment.sig>
