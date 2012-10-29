From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 29 Oct 2012 15:45:36 +0000
Subject: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
In-Reply-To: <1349879449-22657-1-git-send-email-mporter@ti.com>
References: <1349879449-22657-1-git-send-email-mporter@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EAB8596@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matt,

On Wed, Oct 10, 2012 at 20:00:49, Porter, Matt wrote:
> 6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
> exposes a bug in the AM33XX clock data for mcasp. After moving to
> clk_get() usage, the _init() of all registered hwmods fails on mcasp0
> due to incorrect clock data causing clk_get() to fail. This causes all
> successive hwmods to fail to _init() leaving them in a bad state.
> 
> This patch updates the mcasp clock entries so clk_get() will succeed.
> It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
> boot.


I want to test Audio on AM335x Evm with your EDMA patches. I have few 
patches for AM335x.
Can you share the link to the repo & branch on which I need to rebase?
The patches are related to mcasp dt node, mcasp pinmux in dt, etc...

> 
..snip..
..snip..
> 


Thanks & Regards, 
Gururaja
