From: davem@davemloft.net (David Miller)
Date: Sun, 05 Aug 2018 17:12:14 -0700 (PDT)
Subject: [v2, 3/3] ptp_qoriq: support automatic configuration for ptp timer
In-Reply-To: <20180801100554.36634-3-yangbo.lu@nxp.com>
References: <20180801100554.36634-1-yangbo.lu@nxp.com>
 <20180801100554.36634-3-yangbo.lu@nxp.com>
Message-ID: <20180805.171214.1083281848605802821.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Wed,  1 Aug 2018 18:05:54 +0800

> This patch is to support automatic configuration for ptp timer.
> If required ptp dts properties are not provided, driver could
> try to calculate a set of default configurations to initialize
> the ptp timer. This makes the driver work for many boards which
> don't have the required ptp dts properties in current kernel.
> Also the users could set dts properties by themselves according
> to their requirement.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Dropped module_param.

Applied.
