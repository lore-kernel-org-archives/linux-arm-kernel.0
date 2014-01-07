From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:37:48 +0000
Subject: [PATCH 04/11] ASoC: Ux500: Match platform by device node when
 booting Device Tree
In-Reply-To: <1387468508-12286-5-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153748.GM31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:01PM +0000, Lee Jones wrote:
> We're getting closer to fully enabling the Ux500 ASoC driver for Device
> Tree. When we switch over from using AUXDATA we'll need to match platform
> by only Device Tree nodes. In this patch we NULL out the platform_name,
> and supply nodes for each platform device.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/62ff2af5/attachment.sig>
