From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 18:49:36 +0000
Subject: [PATCH 05/10] ASoC: Ux500: Match platform by device node when
 booting Device Tree
In-Reply-To: <1384859269-19801-6-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20131119184936.GG2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:07:44AM +0000, Lee Jones wrote:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/46fd088a/attachment.sig>
