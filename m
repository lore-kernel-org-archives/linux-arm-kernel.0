From: davem@davemloft.net (David Miller)
Date: Tue, 20 Sep 2011 15:08:40 -0400 (EDT)
Subject: [PATCH 0/4] add fec support for imx6q
In-Reply-To: <1316346852-17090-1-git-send-email-shawn.guo@linaro.org>
References: <1316346852-17090-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110920.150840.1516237043684327742.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Sun, 18 Sep 2011 19:54:08 +0800

> This series adds imx6q enet support.  The imx6q enet is a derivative of
> imx28 enet controller.  It fixed the frame endian issue found on imx28,
> and added 1 Gbps support.
> 
> It's based on v3.1-rc6.
> 
> Shawn Guo (4):
>       net/fec: change phy-reset-gpio request warning to debug message
>       net/fec: fix fec1 check in fec_enet_mii_init()
>       net/fec: set phy_speed to the optimal frequency 2.5 MHz
>       net/fec: add imx6q enet support

Please respin this against the net-next tree as that's where these
changes should be targetted and all the ethernet drivers have moved
to different directories in net-next.

Thanks.
