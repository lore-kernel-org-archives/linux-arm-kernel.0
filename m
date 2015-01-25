From: davem@davemloft.net (David Miller)
Date: Sat, 24 Jan 2015 21:55:12 -0800 (PST)
Subject: [PATCH net-next v2 1/1] ARM: dts: imx6sx: correct i.MX6sx sdb
 board enet phy address
In-Reply-To: <1421743697-26918-1-git-send-email-b38611@freescale.com>
References: <1421743697-26918-1-git-send-email-b38611@freescale.com>
Message-ID: <20150124.215512.524443557800262525.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fugang Duan <b38611@freescale.com>
Date: Tue, 20 Jan 2015 16:48:17 +0800

> The commit (3d125f9c91c5) cause i.MX6SX sdb enet cannot work. The cause is
> the commit add mdio node with un-correct phy address.
> 
> The patch just correct i.MX6sx sdb board enet phy address.
> 
> V2:
> * As Shawn's suggestion that unit-address should match 'reg' property, so
>   update ethernet-phy unit-address.
> 
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied.
