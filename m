From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 09:35:20 +0800
Subject: [PATCH v3 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
In-Reply-To: <e24c7d64dbce490fbeaa0f44b56027d0@rwthex-s1-b.rwth-ad.de>
References: <e24c7d64dbce490fbeaa0f44b56027d0@rwthex-s1-b.rwth-ad.de>
Message-ID: <20160616013520.GP20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 01:24:55AM +0200, christopher.spinrath at rwth-aachen.de wrote:
> From: Valentin Raevsky <valentin@compulab.co.il>
> 
> The current ldo settings of the cm-fx6 do not allow 1.2GHz cpu
> frequency. At this frequency the module behaves unstable.
> 
> But the imx6q fuse indicates that 1.2GHz operation is possible.
> Hence, remove the 1.2GHz operation point in the device tree.
> 
> Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
> [christopher.spinrath at rwth-aachen.de: enhance commit message, adjust
>  remaining operation points to match the ones in imx6q.dtsi and add
>  a comment in the device tree]
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
