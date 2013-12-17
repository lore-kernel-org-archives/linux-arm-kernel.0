From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 14:10:38 +0000
Subject: [PATCH] ASoC: kirkwood: Fix the CPU DAI rates
In-Reply-To: <20131127211024.52e5ae1b@armhf>
References: <20131127211024.52e5ae1b@armhf>
Message-ID: <20131217141038.GJ3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 09:10:24PM +0100, Jean-Francois Moine wrote:
> This patch fixes the rates declared in the CPU DAI parameters:
> - SNDRV_PCM_RATE_KNOT and the discrete rates SNDRV_PCM_RATE_xxx should
>   not be used with SNDRV_PCM_RATE_CONTINUOUS,
> - SNDRV_PCM_RATE_CONTINUOUS asks for rate_min and rate_max,
> - the device may do streaming down to 5512Hz.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/d8f27f05/attachment.sig>
