From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 19 Dec 2013 16:09:45 +0000
Subject: [PATCHv4 0/2] CMA for arm64
In-Reply-To: <52B1E96D.1060904@codeaurora.org>
References: <1386876513-7199-1-git-send-email-lauraa@codeaurora.org>
 <52B1E96D.1060904@codeaurora.org>
Message-ID: <20131219160943.GA29174@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 06:29:01PM +0000, Laura Abbott wrote:
> On 12/12/2013 11:28 AM, Laura Abbott wrote:
> > This adds support for CMA in arm64
> >
> > v4: Minor typos pointed out by Will. Changed the support for NULL devices
> > to be a WARN on NULL device.
> >
> > v3: Fix a missed line to actually set the dma_handle correctly
> >
> > v2: Move the dma contiguous functions from swiotlb to arm64 directly
> >
> >   arch/arm64/Kconfig                      |    1 +
> >   arch/arm64/include/asm/dma-contiguous.h |   29 +++++++++++++++++++++++++
> >   arch/arm64/mm/dma-mapping.c             |   35 +++++++++++++++++++++++++++++-
> >   arch/arm64/mm/init.c                    |    3 ++
> >   4 files changed, 66 insertions(+), 2 deletions(-)
> 
> Any further comments on this or is this going to be queued up somewhere?

I'll queue them for the next merging window. I hope to get them into
linux-next by the end of the week.

Thanks.

-- 
Catalin
