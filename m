From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 27 Nov 2012 19:31:30 +0100
Subject: [PATCH 1/1] net: ethernet: cpsw: fix build warnings for CPSW
 when CPTS not selected
In-Reply-To: <1354038820-11095-1-git-send-email-mugunthanvnm@ti.com>
References: <1354038820-11095-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20121127183130.GA7278@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 11:23:40PM +0530, Mugunthan V N wrote:
>   CC      drivers/net/ethernet/ti/cpsw.o
> drivers/net/ethernet/ti/cpsw.c: In function 'cpsw_ndo_ioctl':
> drivers/net/ethernet/ti/cpsw.c:881:20: warning: unused variable 'priv'
> 
> The build warning is generated when CPTS is not selected in Kernel Build.
> Fixing by passing the net_device pointer to cpts IOCTL instead of passing priv
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Thanks for this fix.

Acked-by: Richard Cochran <richardcochran@gmail.com>
