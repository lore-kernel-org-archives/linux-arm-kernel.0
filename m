From: david.vrabel@citrix.com (David Vrabel)
Date: Wed, 17 Jun 2015 16:36:47 +0100
Subject: [Xen-devel] [PATCH v2 0/7] xen: Clean up
In-Reply-To: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
References: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
Message-ID: <5581940F.6020102@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/15 15:28, Julien Grall wrote:
> Hi,
> 
> Thoses patches was originally part of the Xen 64KB series [1]. Although,
> I think they can go without waiting the rest of the 64KB series.
> 
> Patch #1-#4 should go through the Xen tree, even though patch #1 touches
> multiple part.
> 
> Patch #5-#7 should go through the Block tree.

I've applied all of these to for-linus-4.2, thanks.  Including the block
ones since they were trivial and not block-related.

David
