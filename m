From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Oct 2014 12:29:47 +0100
Subject: [PATCH] ASoC: rockchip-i2s: fix infinite loop in
 rockchip_snd_txctrl
In-Reply-To: <1412755131-27542-1-git-send-email-sonnyrao@chromium.org>
References: <1412755131-27542-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <20141008112947.GV4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 08, 2014 at 12:58:51AM -0700, Sonny Rao wrote:
> We can get into an infinite loop if the I2S_CLR register fails to
> clear due to a missing break statement, so add that.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141008/4b1ec437/attachment.sig>
