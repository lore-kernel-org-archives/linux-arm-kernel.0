From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 07 Mar 2016 13:24:25 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <56DD7172.4000707@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de>
Message-ID: <2714888.1DdqvJZ8cb@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Am Montag, 7. M?rz 2016, 13:17:54 schrieb Andreas F?rber:
> Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
> > On next-20160304 the GMAC seems to have regressed, it no longer finds the
> > PHY:
> > 
> > libphy: PHY stmmac-0:ffffffff not found
> > eth0: Could not attach to PHY
> > stmmac_open: Cannot attach to PHY (error: -19)
> 
> Still with us in next-20160307. CC'ing stmmac maintainers.

do you remember from what revision you rebased away from, when it was still 
working (as a known-good state)?


Heiko

> 
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/
> net/ethernet/stmicro
> 
> Regards,
> Andreas
