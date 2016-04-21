From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Apr 2016 06:49:42 -0700
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160413132916.GC19650@bigcity.dyn.berto.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
 <20160315082254.GE9136@infradead.org> <3286525.zPAGiD4Xk2@avalon>
 <20160321152601.GA11674@infradead.org>
 <20160413132916.GC19650@bigcity.dyn.berto.se>
Message-ID: <20160421134942.GA3325@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 03:29:17PM +0200, Niklas S?derlund wrote:
> > Yes, it would be good to do an audit of all the ARM dma_ops as well
> > as generic code like drivers/base/dma-*.c, lib/dma-debug.c and
> > include/linux/dma-*.h

What about things like the phys_addr() helper in lib/dma-debug.c?  That
was in fact what prompted my question for an audit, and it seems
to not even feature on your list.  What patterns / symbols did you look
for?
