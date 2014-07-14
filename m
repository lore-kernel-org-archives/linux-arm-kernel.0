From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 19:51:26 +0100
Subject: [PATCH 1/4] ASoC: samsung: add explicit i2c/spi dependencies
In-Reply-To: <1405086308-1461192-3-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-3-git-send-email-arnd@arndb.de>
Message-ID: <20140714185126.GB6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:45:04PM +0200, Arnd Bergmann wrote:
> I got another build error from SND_SOC_SMARTQ selecting
> SND_SOC_WM8750 without ensuring that I2C is enabled,
> in this example, i2c is a loadable module:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/f16b302c/attachment-0001.sig>
