From: davem@davemloft.net (David Miller)
Date: Fri, 01 Apr 2016 14:43:56 -0400 (EDT)
Subject: [PATCH] net: mvpp2: use cache_line_size() to get cacheline size
In-Reply-To: <1459501865-7033-1-git-send-email-jszhang@marvell.com>
References: <1459501865-7033-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160401.144356.340761425248303262.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Fri, 1 Apr 2016 17:11:05 +0800

> L1_CACHE_BYTES may not be the real cacheline size, use cache_line_size
> to determine the cacheline size in runtime.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Suggested-by: Marcin Wojtas <mw@semihalf.com>

Applied.
