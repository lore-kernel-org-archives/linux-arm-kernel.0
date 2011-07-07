From: davem@davemloft.net (David Miller)
Date: Thu, 07 Jul 2011 04:12:57 -0700 (PDT)
Subject: [PATCH] net/fec: gasket needs to be enabled for some i.mx
In-Reply-To: <1309515082-7386-1-git-send-email-shawn.guo@linaro.org>
References: <20110630161935.GA7977@S2100-06.ap.freescale.net>
	<1309515082-7386-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110707.041257.670268148869400054.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Fri,  1 Jul 2011 18:11:22 +0800

> On the recent i.mx (mx25/50/53), there is a gasket inside fec
> controller which needs to be enabled no matter phy works in MII
> or RMII mode.
> 
> The current code enables the gasket only when phy interface is RMII.
> It's broken when the driver works with a MII phy.  The patch uses
> platform_device_id to distinguish the SoCs that have the gasket and
> enables it on these SoCs for both MII and RMII mode.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
