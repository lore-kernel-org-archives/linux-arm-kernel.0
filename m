From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 19:01:28 +0000
Subject: [PATCH v2] ASoC: rockchip: i2s: Fix Kconfig for I2S device driver
In-Reply-To: <1416599446-32310-1-git-send-email-rupran@einserver.de>
References: <20141121185856.GJ3815@sirena.org.uk>
 <1416599446-32310-1-git-send-email-rupran@einserver.de>
Message-ID: <20141124190128.GI7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 08:50:46PM +0100, Andreas Ruprecht wrote:
> Currently, CONFIG_SND_SOC_ROCKCHIP_I2S could also be selected
> without having CONFIG_SND_SOC_ROCKCHIP enabled.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/002524ec/attachment.sig>
