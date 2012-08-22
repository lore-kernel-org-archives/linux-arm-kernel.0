From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:18:35 +0100
Subject: [PATCH] ASoC: omap-mcbsp: Device tree binding documentation update
In-Reply-To: <1345559636-23370-1-git-send-email-peter.ujfalusi@ti.com>
References: <1345559636-23370-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191835.GQ7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 05:33:56PM +0300, Peter Ujfalusi wrote:
> To reflect the final devicetree node structure of McBSPs.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied, thanks.

> the initial OMAP McBSP DT structure was not able to describe the IP (and it's
> versions) correctly.
> The main issue was the sidetone block of McBSP2/3 on OMAP3.
> With this change in the DT description the OS can get the needed information
> about the IP.
> 
> The sidetone is still not supported when the Linux kernel is booted with DT
> since we still depend on hwmod to fill the resources.

I pasted this into the changelog to explain what's going on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/eb5e9878/attachment-0001.sig>
