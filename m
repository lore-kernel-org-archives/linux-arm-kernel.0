From: davem@davemloft.net (David Miller)
Date: Fri, 15 Mar 2013 08:57:39 -0400 (EDT)
Subject: [PATCH net-next] drivers:net: Remove dma_alloc_coherent OOM
 messages
In-Reply-To: <1363302441.2146.30.camel@joe-AO722>
References: <1363302441.2146.30.camel@joe-AO722>
Message-ID: <20130315.085739.1428933964050018561.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joe Perches <joe@perches.com>
Date: Thu, 14 Mar 2013 16:07:21 -0700

> I believe these error messages are already logged
> on allocation failure by warn_alloc_failed and so
> get a dump_stack on OOM.
> 
> Remove the unnecessary additional error logging.
> 
> Around these deletions:
> 
> o Alignment neatening.
> o Remove unnecessary casts of dma_alloc_coherent.
> o Hoist assigns from ifs.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks Joe.
