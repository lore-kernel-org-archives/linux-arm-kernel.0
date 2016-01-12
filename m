From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 12 Jan 2016 13:50:07 +0100
Subject: [PATCH v3 00/41] arch: barrier cleanup + barriers for virt
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Message-ID: <20160112125007.GR6344@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 04:16:22PM +0200, Michael S. Tsirkin wrote:
> I parked this in vhost tree for now, though the inclusion of patch 1 from tip
> creates a merge conflict - but one that is trivial to resolve.
> 
> So I intend to just merge it all through my tree, including the
> duplicate patch, and assume conflict will be resolved.
> 
> I would really appreciate some feedback on arch bits (especially the x86 bits),
> and acks for merging this through the vhost tree.

Thanks for doing this, looks good to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
