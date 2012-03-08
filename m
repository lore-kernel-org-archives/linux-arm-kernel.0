From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Mar 2012 10:59:21 +0000
Subject: [PATCH v2 3/3] ASoC: omap-mcbsp: Single function CLKR/FSR source
 mux configuration
In-Reply-To: <1331198537-13469-4-git-send-email-peter.ujfalusi@ti.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
 <1331198537-13469-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120308105921.GB3638@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 11:22:17AM +0200, Peter Ujfalusi wrote:
> Use single function for the CLKR/FSR mux configuration.
> OMAP2/3 has 6 pin configuration on McBSP1 instance, while on OMAP4
> McBSP4 instance have the 6 pin configuration so the omap2_mcbsp1_mux_* is
> not correct name for all support OMAP versions

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/9d7272e7/attachment.sig>
