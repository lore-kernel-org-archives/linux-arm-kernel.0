From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 20:30:57 -0700
Subject: [PATCH 03/15] ASoC: SMDK_WM8580_PCM needs REGMAP_I2C
In-Reply-To: <1398770316-19715-4-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-4-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501033057.GO3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:24PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This adds a missing dependency for SND_SOC_SMDK_WM8580_PCM to
> require REGMAP_I2C to be enabled, avoiding possible build
> erorrs.

Applied, thanks.  As well as the Cc list thing please try to use subject
lines matching the style for the subsystem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/1971b613/attachment-0001.sig>
