From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Feb 2012 07:46:31 -0800
Subject: [PATCH] ASoC: imx/mxs: remove redundant SND_PCM selection
In-Reply-To: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
References: <1329721524-28394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120220154628.GC3258@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 03:05:24PM +0800, Shawn Guo wrote:
> SND_PCM is already selected by SND_SOC, there is no need for
> SND_IMX_SOC and SND_MXS_SOC to select it again.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120220/164feaa5/attachment.sig>
