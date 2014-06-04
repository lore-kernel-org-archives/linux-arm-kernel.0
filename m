From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 16:45:49 +0100
Subject: [PATCH] ASoC: samsung: Add I2C dependency for snow
In-Reply-To: <7290614.Z7JFMYFomx@wuerfel>
References: <7290614.Z7JFMYFomx@wuerfel>
Message-ID: <20140604154549.GO2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 11:40:40AM +0200, Arnd Bergmann wrote:
> Both codecs used by snow, max98090 and max98095 require the use
> of I2C, so we can only select this driver if I2C is there, otherwise
> we get a build error like:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/1608efaf/attachment.sig>
