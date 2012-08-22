From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:15:06 +0100
Subject: [PATCH v3 5/9] ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux
 configuration code
In-Reply-To: <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191506.GL7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:04PM +0300, Peter Ujfalusi wrote:
> Remove the feature to configure the CLKR/FSR mux on McBSP port with 6pin
> configuration.
> When moving to devicetree these callback can no longer be used in a clean
> way anymore.

Applied but this didn't quite apply cleanly, please check that it did so.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/05bd1732/attachment.sig>
