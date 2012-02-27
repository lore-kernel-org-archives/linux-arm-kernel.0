From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Feb 2012 14:36:55 +0000
Subject: [PATCH] ASoC: imx: let SND_MXC_SOC_FIQ select FIQ
In-Reply-To: <1329900026-24270-1-git-send-email-shawn.guo@linaro.org>
References: <1329900026-24270-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120227143655.GI3191@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 04:40:26PM +0800, Shawn Guo wrote:
> CONFIG_FIQ is only needed when CONFIG_SND_MXC_SOC_FIQ is selected to
> build imx-pcm-fiq.c, so let SND_MXC_SOC_FIQ select FIQ.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/3d9b3e68/attachment.sig>
