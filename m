From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 15 May 2018 11:47:49 +0200
Subject: [PATCH 26/61] media: platform: exynos4-is: simplify getting
 .drvdata
In-Reply-To: <20180419140641.27926-27-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-27-wsa+renesas@sang-engineering.com>
 <CGME20180515094754epcas2p2715cc9c6376ddbb5f400830ef41b514b@epcas2p2.samsung.com>
Message-ID: <613c3648-1d2e-e008-60a8-d9f21eca9fae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
