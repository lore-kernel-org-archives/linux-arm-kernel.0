From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Feb 2012 12:34:49 +0000
Subject: [PATCH 1/6] ASoC: fsl: correct get_dma_channel parameter name
In-Reply-To: <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120228123449.GE3683@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:09:36PM +0800, Shawn Guo wrote:
> The second parameter of function get_dma_channel is actually a property
> name rather than a compatible string, so rename it for less confusing.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120228/6998310a/attachment.sig>
