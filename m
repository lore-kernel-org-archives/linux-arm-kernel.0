From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Jan 2015 17:07:03 +0200
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
In-Reply-To: <20150121150529.GA30345@8bytes.org>
References: <20150119140106.GM6343@8bytes.org> <7446358.Tz4W75qRf1@avalon>
 <20150121150529.GA30345@8bytes.org>
Message-ID: <3530276.KVdcG9umfv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Wednesday 21 January 2015 16:05:29 joro at 8bytes.org wrote:
> On Wed, Jan 21, 2015 at 04:58:12PM +0200, Laurent Pinchart wrote:
> > All my other ipmmu patches have been queued by Joerg in his next branch,
> > on which this patch is based. If you base your series on the same branch
> > you can just queue this patch on top of it. Do you plan to submit the
> > result to v3.20 or v3.21 ?
> 
> Hmm, I would prefer to not merge stuff together like this. Preferably I
> would like to put the generic page-table patches for ARM in a seperate
> topic-branch without any other changes merged in, given that this does
> not cause any non-trivial merge conflicts in the end for my next branch.

As you wish. I just thought you would prefer merging the series with at least 
one user.

-- 
Regards,

Laurent Pinchart
