From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 18:30:06 -0700
Subject: [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs depend on INPUT
In-Reply-To: <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501013006.GJ3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:22PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building ARM randconfig got into a situation where CONFIG_INPUT
> is turned off and SND_SOC_ALL_CODECS is turned on, which failed
> for two codecs trying to use the input subsystem. Some other 

Applied, but...

> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Timur Tabi <timur@tabi.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-input at vger.kernel.org
> Cc: alsa-devel at alsa-project.org

...please don't include noise like this in patch submissions, especially
with such long lists (which still manage to miss the driver maintainers
concerned).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/296e80c8/attachment-0001.sig>
