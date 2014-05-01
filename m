From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 13:29:32 -0700
Subject: [PATCH 10/15] ASoC: TLV320AIC23 and Simtec Hermes audio
In-Reply-To: <1398770316-19715-11-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-11-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20140501202932.GC3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 07:18:31PM +0800, Xia Kaixu wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This codec requires I2C to be enabled, so any other option
> that selects it should also depend on I2C.

Applied, thanks.  Please try to use meaningful subject lines.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/8a6bec76/attachment.sig>
