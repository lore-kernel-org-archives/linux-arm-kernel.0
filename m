From: davem@davemloft.net (David Miller)
Date: Fri, 06 Nov 2015 23:31:44 -0500 (EST)
Subject: [PATCH net-next] drivers: net: xgene: fix RGMII 10/100Mb mode
In-Reply-To: <1446788107-31856-1-git-send-email-isubramanian@apm.com>
References: <1446788107-31856-1-git-send-email-isubramanian@apm.com>
Message-ID: <20151106.233144.1936295198775628276.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Thu,  5 Nov 2015 21:35:06 -0800

> This patch fixes the RGMII 10/100M mode by reprogramming the clock.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Fushen Chen <fchen@apm.com>

Why are you targetting a bug fix at net-next?  That is inappropriate.
