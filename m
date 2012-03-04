From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:41:35 +0000
Subject: [PATCH 09/20] ASoC: imx: separate imx-pcm bits from imx-ssi driver
In-Reply-To: <1330788001-10158-10-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304134135.GG3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:19:50PM +0800, Shawn Guo wrote:
> Currently the imx-ssi.c[h] accommodates the imx-pcm common bits which
> are shared between imx-pcm-dma-mx2 and imx-pcm-fiq drivers.  It assumes
> that imx-pcm-dma-mx2 and imx-pcm-fiq will always be used together with
> imx-ssi driver.  However this becomes untrue when we see that driver
> sound/soc/fsl/fsl_ssi could possibly work with imx-pcm-dma-mx2 too.

I was going to apply this and the next patch but they depend on the
audmux stuff so they'll at least have to wait until that gets applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/8b06decc/attachment.sig>
