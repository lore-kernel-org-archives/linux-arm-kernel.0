From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 7 Mar 2016 13:17:54 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <1457294038-14243-1-git-send-email-afaerber@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
Message-ID: <56DD7172.4000707@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
> On next-20160304 the GMAC seems to have regressed, it no longer finds the PHY:
> 
> libphy: PHY stmmac-0:ffffffff not found
> eth0: Could not attach to PHY
> stmmac_open: Cannot attach to PHY (error: -19)

Still with us in next-20160307. CC'ing stmmac maintainers.

http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/net/ethernet/stmicro

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
