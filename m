From: broonie@kernel.org (Mark Brown)
Date: Wed, 27 Nov 2013 17:16:48 +0000
Subject: [PATCH] ASoC: kirkwood: Fix erroneous double output while playing
In-Reply-To: <20131125201905.0d009921@armhf>
References: <20131125201905.0d009921@armhf>
Message-ID: <20131127171648.GN14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 08:19:05PM +0100, Jean-Francois Moine wrote:
> This patch fixes the setting of the register KIRKWOOD_PLAYCTL which did
> always streaming on both I2S and SPDIF, ignoring the DAI ID.

Applied, thanks.

> The bug was introduced by the commit 75b9b65ee5a
>  "ASoC: kirkwood: add S/PDIF support"

There's the "Fixes:" tag for that now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131127/23ccc50d/attachment.sig>
