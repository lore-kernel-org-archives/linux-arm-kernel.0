From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 13:30:14 -0700
Subject: [PATCH 09/15] ASoC: Migo-R sound needs I2C
In-Reply-To: <1398770316-19715-10-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-10-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501203014.GD3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:30PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The WM8978 driver needs I2C to be enabled, so the
> SND_SIU_MIGOR option also requires this.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/fbf48aea/attachment.sig>
