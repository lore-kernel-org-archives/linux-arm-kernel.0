From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 14 Nov 2016 15:34:02 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q-cm-fx6: fix fec pinctrl
In-Reply-To: <6cd823201b9f4cde8de8eddc910f39ce@rwthex-s1-b.rwth-ad.de>
References: <6cd823201b9f4cde8de8eddc910f39ce@rwthex-s1-b.rwth-ad.de>
Message-ID: <20161114073401.GM3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 04:59:38PM +0100, christopher.spinrath at rwth-aachen.de wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> 
> According to the schematics of CompuLab's sbc-fx6 baseboard and the
> vendor devicetree GPIO_16 is *not* muxed to ENET_REF_CLK but to SPDIF_IN.
> 
> Remove the wrong pinctrl setting.
> 
> Fixes: 682d055e6ac5 ("ARM: dts: Add initial support for cm-fx6.")
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

Applied both, thanks.
