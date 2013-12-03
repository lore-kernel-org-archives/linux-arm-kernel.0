From: broonie@kernel.org (Mark Brown)
Date: Tue, 3 Dec 2013 15:07:55 +0000
Subject: [PATCH 1/2] ASoC: ux500_pcm: Differentiate between pdata and DT
 initialisation
In-Reply-To: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20131203150755.GZ27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 10:27:06AM +0000, Lee Jones wrote:
> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible_request_channel call
> back or require some of the historical bumph which probably isn't
> required by a platform data start-up now either. This will also be
> ripped out in upcoming commits.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131203/667f1285/attachment.sig>
