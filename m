From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 10:13:33 +0100
Subject: [PATCH 2/6] ASoC: mxs: use devm_clk_get for mxs_saif_probe
In-Reply-To: <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120510091332.GF3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 04:42:09PM +0800, Shawn Guo wrote:
> Use devm_clk_get for mxs_saif_probe to ease the cleanup.

Please stop submitting devm_clk_get() changes until it's in mainline, as
I've said with all the similar changs this can't be applied until that
API can be merged up into ASoC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/d297f1f9/attachment-0001.sig>
