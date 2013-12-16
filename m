From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 20:15:00 +0000
Subject: [PATCH 1/2] ASoC: sgtl5000: read chip revision for once
In-Reply-To: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131216201500.GS3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:43:02PM +0800, Shawn Guo wrote:
> Store chip revision in struct sgtl5000_priv when sgtl5000_i2c_probe()
> reads it out from register, so that we can use it in
> sgtl5000_enable_regulators() with no need to read register again.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/23d2cace/attachment.sig>
