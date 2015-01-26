From: joro@8bytes.org (joro at 8bytes.org)
Date: Mon, 26 Jan 2015 13:46:03 +0100
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
In-Reply-To: <2654819.qtgnKgjAAR@avalon>
References: <20150119140106.GM6343@8bytes.org> <3530276.KVdcG9umfv@avalon>
 <20150121152724.GB30345@8bytes.org> <2654819.qtgnKgjAAR@avalon>
Message-ID: <20150126124603.GE4653@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 05:31:05PM +0200, Laurent Pinchart wrote:
> On Wednesday 21 January 2015 16:27:24 joro at 8bytes.org wrote:
> > On Wed, Jan 21, 2015 at 05:07:03PM +0200, Laurent Pinchart wrote:
> > > As you wish. I just thought you would prefer merging the series with at
> > > least one user.
> > 
> > Yes, and with your patch there would be two users: ARM-SMMU and the VMSA
> > IPMMU. So ideally I would apply/pull Will's patches on v3.19-rc5 with
> > your patch on-top (and no other patches as dependency).
> 
> But that would conflict with the IPMMU patches that you have already queued 
> for v3.20.

Okay, I merged the arm/smmu branch into arm/renesas and applied your
patch on-top.
