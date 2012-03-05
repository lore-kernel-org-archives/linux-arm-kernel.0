From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 17:46:13 +0000
Subject: [PATCH v2 01/17] ASoC: imx: move eukrea audmux call into ASoC
 machine driver
In-Reply-To: <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120305174612.GY3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:30:49PM +0800, Shawn Guo wrote:
> It moves eukrea audmux configuration call from board file into ASoC
> machine driver eukrea-tlv320, so that it gets aligned wm1133-ev1 and
> mx27vis-aic32x4, and more importantly it will ease the moving of audmux
> into sound/soc/imx as a platform driver later.

Sascha, this and the second patch look totally uncontroversial - can we
just apply them now so we don't need to keep reviewing them?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/22f881e2/attachment.sig>
