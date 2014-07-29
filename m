From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Jul 2014 15:36:41 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: add always on pcie regulator
In-Reply-To: <1406136551-8015-1-git-send-email-l.stach@pengutronix.de>
References: <1406136551-8015-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140729073640.GB24750@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 07:29:11PM +0200, Lucas Stach wrote:
> Everything in the PCI specification assumes devices to be
> enumerable on startup. This is only possible if they have
> power available.
> 
> A future improvement may allow this regulator to be switched
> off for D3hot and D3cold power states, but there is a lot
> of work to do the pcie host controller side for this to work.
> To keep things simple always enable the regulator for now.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Applied, thanks.
