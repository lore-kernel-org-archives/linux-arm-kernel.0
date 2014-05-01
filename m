From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 Apr 2014 20:32:37 -0700
Subject: [PATCH 05/15] ASoC: nuc900: export nuc900_ac97_data
In-Reply-To: <1398770316-19715-6-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-6-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501033237.GQ3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:26PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The symbol "nuc900_ac97_data" is used by the nuc900_pcm driver, 
> which may be a loadable module, so we should export it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/01b383cf/attachment.sig>
