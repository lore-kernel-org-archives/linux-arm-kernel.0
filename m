From: davem@davemloft.net (David Miller)
Date: Wed, 16 Nov 2016 17:51:54 -0500 (EST)
Subject: [PATCH] net: bcm63xx_enet: fix build failure
In-Reply-To: <1479336616-26500-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1479336616-26500-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <20161116.175154.767887282639567610.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Wed, 16 Nov 2016 22:50:16 +0000

> The build of mips bcm63xx_defconfig was failing with the error:
> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1440:2:
> 	error: expected expression before 'return'
> 
> The return statement should be termibated with ';' and not ','.
> 
> Fixes: 42469bf5d9bb ("net: bcm63xx_enet: Utilize phy_ethtool_nway_reset")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Already fixes in the current net-next tree.
