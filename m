From: davem@davemloft.net (David Miller)
Date: Wed, 28 Nov 2012 17:51:34 -0500 (EST)
Subject: [PATCH 1/1] net: ethernet: cpsw: fix build warnings for CPSW
 when CPTS not selected
In-Reply-To: <1354038820-11095-1-git-send-email-mugunthanvnm@ti.com>
References: <1354038820-11095-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20121128.175134.357731690357578238.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Tue, 27 Nov 2012 23:23:40 +0530

>   CC      drivers/net/ethernet/ti/cpsw.o
> drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_ndo_ioctl':
> drivers/net/ethernet/ti/cpsw.c:881:20: warning: unused variable 'priv'
> 
> The build warning is generated when CPTS is not selected in Kernel Build.
> Fixing by passing the net_device pointer to cpts IOCTL instead of passing priv
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied.
