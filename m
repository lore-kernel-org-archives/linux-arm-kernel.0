From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 12 Jan 2013 00:05:28 +0000
Subject: [PATCH] ASoC: fsl: fix multiple definition of init_module
In-Reply-To: <1357832636-11463-1-git-send-email-shawn.guo@linaro.org>
References: <1357832636-11463-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130112000528.GE7873@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:43:56PM +0800, Shawn Guo wrote:
> With commit f2818d0 (ASoC: fsl: fix miscompilation of snd-soc-imx-pcm),
> we will see the following build error when building modules with
> CONFIG_SND_IMX_SOC=m in imx_v6_v7_defconfig.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130112/c8451c7c/attachment.sig>
