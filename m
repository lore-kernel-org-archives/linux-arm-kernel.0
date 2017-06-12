From: davem@davemloft.net (David Miller)
Date: Mon, 12 Jun 2017 09:51:21 -0400 (EDT)
Subject: [PATCH v1] net/phy: Make phy_ethtool_ksettings_get return void
In-Reply-To: <20170612074233.8688-1-yuval.shaia@oracle.com>
References: <20170612074233.8688-1-yuval.shaia@oracle.com>
Message-ID: <20170612.095121.1880452682603577061.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 12 Jun 2017 10:42:33 +0300

> Make return value void since function never return meaningfull value
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> ---
> Re-sending since last time forgot to add netdev-list
> v0 ->v1:
> 	* These files were missing in v0
> 		* drivers/net/ethernet/renesas/ravb_main.c
> 		* drivers/net/ethernet/renesas/sh_eth.c
> 		* drivers/net/ethernet/ti/netcp_ethss.c
> 	* Add Acked-by: Sergei Shtylyov

This doesn't apply cleanly to net-next at all.

Please respin against an uptodate net-next tree, thank you.
