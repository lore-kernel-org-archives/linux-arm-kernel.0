From: davem@davemloft.net (David Miller)
Date: Tue, 02 Jan 2018 21:56:49 -0500 (EST)
Subject: [PATCH] ethernet/broadcom: Use zeroing memory allocator than
 allocator/memset
In-Reply-To: <1514648697-7148-1-git-send-email-himanshujha199640@gmail.com>
References: <1514648697-7148-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <20180102.215649.684091832316614533.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Himanshu Jha <himanshujha199640@gmail.com>
Date: Sat, 30 Dec 2017 21:14:57 +0530

> Use dma_zalloc_coherent for allocating zeroed
> memory and remove unnecessary memset function.
> 
> Done using Coccinelle.
> Generated-by: scripts/coccinelle/api/alloc/kzalloc-simple.cocci
> 0-day tested with no failures.
> 
> Suggested-by: Luis R. Rodriguez <mcgrof@kernel.org>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Applied.
