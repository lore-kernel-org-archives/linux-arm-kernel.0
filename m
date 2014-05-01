From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 11:01:04 -0700
Subject: [PATCH 08/15] ASoC: TTC DKB audio needs I2C
In-Reply-To: <1398770316-19715-9-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-9-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501180103.GN3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:29PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The missing dependency can lead to build errors, so
> make it explicit in Kconfig.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/a720ac27/attachment.sig>
