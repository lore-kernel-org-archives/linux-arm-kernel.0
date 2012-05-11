From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 11 May 2012 22:52:01 +0100
Subject: [PATCH] ASoC: fsl: fix the binding of imx-sgtl5000
In-Reply-To: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
References: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120511215201.GF29835@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 10:44:23PM +0800, Shawn Guo wrote:
> The sgtl5000 data sheet does not particularly mention that the Mic Bias
> will internally supplies to MIC_IN, so fix the example in imx-sgtl5000
> binding document to have a better reflection of the actual circuit.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120511/ee0b6244/attachment.sig>
