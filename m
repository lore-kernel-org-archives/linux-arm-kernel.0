From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:10:44 +0100
Subject: [PATCH v3 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting
 code to ASoC driver
In-Reply-To: <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191043.GH7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:00PM +0300, Peter Ujfalusi wrote:
> Move the McBSP CLKS re-parenting code to ASoC driver from
> arch/arm/mach-omap2.
> The call fort the re-parenting has been already limited to OMAP2+ SoC in
> the ASoC driver. There is no longer need to have callback function for it.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/f4452c46/attachment.sig>
