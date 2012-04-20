From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Apr 2012 14:22:55 +0200
Subject: [PATCHv24 00/16] Contiguous Memory Allocator
In-Reply-To: <20120419124044.632bfa49.akpm@linux-foundation.org>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
 <20120419124044.632bfa49.akpm@linux-foundation.org>
Message-ID: <03b201cd1ef0$50ca9350$f25fb9f0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thursday, April 19, 2012 9:41 PM Andrew Morton wrote:

> On Tue, 03 Apr 2012 16:10:05 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > This is (yet another) update of CMA patches.
> 
> Looks OK to me.  It's a lot of code.
> 
> Please move it into linux-next, and if all is well, ask Linus to pull
> the tree into 3.5-rc1.  Please be sure to cc me on that email.

Ok, thanks! Is it possible to get your acked-by or reviewed-by tag? It
might help a bit to get the pull request accepted by Linus. :)

> I suggest that you include additional patches which enable CMA as much
> as possible on as many architectures as possible so that it gets
> maximum coverage testing in linux-next.  Remove those Kconfig patches
> when merging upstream.
> 
> All this code will probably mess up my tree, but I'll work that out.
> It would be more awkward if the CMA code were to later disappear from
> linux-next or were not merged into 3.5-rc1.  Let's avoid that.

I've put the patches on my dma-mapping-next branch and we will see the
result (and/or complaints) on Monday.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
