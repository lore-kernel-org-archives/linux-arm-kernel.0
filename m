From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:15:48 +0100
Subject: [PATCH v3 7/9] ASoC: omap-mcbsp: Remove cpu_is_omap* checks from
 the code
In-Reply-To: <1345124468-8876-8-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-8-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191547.GN7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:06PM +0300, Peter Ujfalusi wrote:
> We can use the has_ccr flag to replace the cpu_is_omap* checks.
> This provides future proof implementation and we do not need to update the
> code if new OMAP revision starts to use the McBSP driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/167d77bd/attachment.sig>
