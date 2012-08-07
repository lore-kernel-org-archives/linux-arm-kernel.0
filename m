From: davem@davemloft.net (David Miller)
Date: Tue, 07 Aug 2012 16:25:20 -0700 (PDT)
Subject: [PATCH 0/2] Add device tree support for davinci_mdio driver
 and fix cpsw DT binding documentation
In-Reply-To: <1344265558-5724-1-git-send-email-mugunthanvnm@ti.com>
References: <1344265558-5724-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20120807.162520.1932972414873138617.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Mon, 6 Aug 2012 20:35:56 +0530

> This patch set adds support for device tree for Davinci MDIO driver and fixes
> CPSW DT binding documentation to make it copy pastable to dts file.
> 
> This patch set is tested with the following git tree on AM335X Beagle Bone
> https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-cpsw
> 
> Mugunthan V N (2):
>   drivers: net: ethernet: davince_mdio: device tree implementation
>   documentation: dt: bindings: cpsw: fixing the examples for directly
>     using it in dts file

Applied to net-next, thanks.
