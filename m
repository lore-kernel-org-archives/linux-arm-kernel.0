From: davem@davemloft.net (David Miller)
Date: Fri, 12 Apr 2013 18:26:12 -0400 (EDT)
Subject: [PATCH] ethernet/fec: Add Vybrid family fec support
In-Reply-To: <1365750765-3615-1-git-send-email-b35083@freescale.com>
References: <1365750765-3615-1-git-send-email-b35083@freescale.com>
Message-ID: <20130412.182612.1613373240725639505.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>
Date: Fri, 12 Apr 2013 15:12:45 +0800

> Freescale Vybrid platform implentments MAC-ENET core
> providing compatibility with half- or full-duplex
> 10/100 Mbit/s Ethernet LANs.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/net/ethernet/freescale/fec.c | 5 +++++

Applied, but the driver source file is now named:

	drivers/net/ethernet/freescale/fec_main.c

in net-next, so I had to edit your patch.
