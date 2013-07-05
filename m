From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Jul 2013 18:33:21 +0100
Subject: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
In-Reply-To: <201307051745.16140.arnd@arndb.de>
References: <201307051745.16140.arnd@arndb.de>
Message-ID: <20130705173321.GE27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 05:45:15PM +0200, Arnd Bergmann wrote:
> This is required so we can build the imx sound support
> when ALSA itself is a loadable module.

Is this actually OK with the FIQ APIs?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/e530bf92/attachment.sig>
