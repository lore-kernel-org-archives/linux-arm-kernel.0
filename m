From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jul 2012 20:18:25 +0100
Subject: [PATCH 2/4] ASoC: mxs-saif: set a base clock rate for EXTMASTER
 mode work
In-Reply-To: <1342776027-31758-3-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-3-git-send-email-b29396@freescale.com>
Message-ID: <20120724191825.GD3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:25PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Set an initial clock rate for the saif internal logic to work
> properly. This is important when working in EXTMASTER mode that
> uses the other saif's BITCLK&LRCLK but it still needs a basic
> clock which should be fast enough for the internal logic.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120724/ef50579a/attachment.sig>
