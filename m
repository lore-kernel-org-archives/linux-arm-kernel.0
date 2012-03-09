From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 11:51:41 +0000
Subject: [PATCH v3 07/11] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-8-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120309115132.GC3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 12:59:46AM +0800, Shawn Guo wrote:

> Check /compatible rather than /model to determine the machine name.
> The p1022ds older device trees get a different /model from the new
> ones, while /compatible is consistent there, so checking /compatible
> will save the bother of detecting older p1022ds device trees.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/654b53c9/attachment-0001.sig>
