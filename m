From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 19 Apr 2012 12:40:44 -0700
Subject: [PATCHv24 00/16] Contiguous Memory Allocator
In-Reply-To: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120419124044.632bfa49.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Apr 2012 16:10:05 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This is (yet another) update of CMA patches.

Looks OK to me.  It's a lot of code.

Please move it into linux-next, and if all is well, ask Linus to pull
the tree into 3.5-rc1.  Please be sure to cc me on that email.

I suggest that you include additional patches which enable CMA as much
as possible on as many architectures as possible so that it gets
maximum coverage testing in linux-next.  Remove those Kconfig patches
when merging upstream.

All this code will probably mess up my tree, but I'll work that out. 
It would be more awkward if the CMA code were to later disappear from
linux-next or were not merged into 3.5-rc1.  Let's avoid that.
