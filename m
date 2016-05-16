From: davem@davemloft.net (David Miller)
Date: Mon, 16 May 2016 13:40:14 -0400 (EDT)
Subject: [PATCH 0/2] net: pxa168_eth: improve performance
In-Reply-To: <1463140650-7038-1-git-send-email-jszhang@marvell.com>
References: <1463140650-7038-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160516.134014.1782979464569219380.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Fri, 13 May 2016 19:57:28 +0800

> This series is to improve the pxa168_eth driver performance by using
> {readl|writel}_relaxed or appropriate memory barriers.

Applied.
