From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 28 Mar 2014 15:14:12 -0700
Subject: [RESEND][PATCH 0/2] Cleanup asm/scatterlist.h
In-Reply-To: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140328151412.9d3ce44ee4c5ad3b1c75751d@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 Mar 2014 11:13:50 -0700 Laura Abbott <lauraa@codeaurora.org> wrote:

> I haven't gotten many responses so I'm going to try sending again
> (this time with a cover letter which I probably should have done in
> the first place...)
> 
> ARCH_HAS_SG_CHAIN is currently defined as needed in asm/scatterlist.h.
> It was suggested[1] that this should probably be a proper Kconfig.
> At the same time, we can clean up most of the asm/scatterlist.h files
> to reduce redundancy. This makes parisc the only architecture that still
> has an asm/scatterlist.h file due to the #define sg_virt_addr (which
> could probably be cleaned up further still)
> 
> Andrew, once we get a few more Acked-bys can we take this through your tree
> as suggested by Will?

Grabbed.  It's super late for 3.15-rc1 and I'm thinking of merging this
in 3.16-rc1.  Or I can maybe squeeze it into 3.15-rc2 is there's an
immediatish need for it?
