From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:39:17 +0000
Subject: [PATCH 10/11] ASoC: ux500_pcm: Differentiate between pdata and
 DT initialisation
In-Reply-To: <1387468508-12286-11-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-11-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153917.GS31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:07PM +0000, Lee Jones wrote:
> If booting with full DT support (i.e. DMA too, the last piece of the
> puzzle), then we don't need to use the compatible_request_channel call
> back or require some of the historical bumph which probably isn't
> required by a platform data start-up now either. This will also be
> ripped out in upcoming commits.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/8400f21e/attachment-0001.sig>
