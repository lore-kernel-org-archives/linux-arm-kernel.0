From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:34:43 +0000
Subject: [PATCH 07/20] ASoC: imx: move SND_SOC_AC97_BUS selection down to
 machine driver
In-Reply-To: <1330788001-10158-8-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120304133442.GD3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 03, 2012 at 11:19:48PM +0800, Shawn Guo wrote:
> SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
> Rather than selecting the option under SND_IMX_SOC, it's better to
> leave the selection to individual machine driver which knows if AC97
> support is needed or not.

Applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/62d0b617/attachment.sig>
