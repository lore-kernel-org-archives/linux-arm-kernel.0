From: davem@davemloft.net (David Miller)
Date: Fri, 01 Apr 2016 14:44:01 -0400 (EDT)
Subject: [PATCH] net: mvneta: use cache_line_size() to get cacheline size
In-Reply-To: <1459501969-7083-1-git-send-email-jszhang@marvell.com>
References: <1459501969-7083-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160401.144401.152232996846825369.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>
Date: Fri, 1 Apr 2016 17:12:49 +0800

> L1_CACHE_BYTES may not be the real cacheline size, use cache_line_size
> to determine the cacheline size in runtime.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Suggested-by: Marcin Wojtas <mw@semihalf.com>

Applied.
