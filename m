From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 10:59:58 -0700
Subject: [PATCH 07/15] ASoC: UDA1380 needs I2C
In-Reply-To: <1398770316-19715-8-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-8-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501175958.GM3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:28PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The UDA1380 driver needs I2C to be enabled, so 
> SND_SOC_SAMSUNG_H1940_UDA1380 and 
> SND_SOC_SAMSUNG_RX1950_UDA1380 also 
> require this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/32d6c36e/attachment.sig>
