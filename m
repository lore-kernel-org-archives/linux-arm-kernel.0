From: joro@8bytes.org (joro at 8bytes.org)
Date: Wed, 21 Jan 2015 16:27:24 +0100
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
In-Reply-To: <3530276.KVdcG9umfv@avalon>
References: <20150119140106.GM6343@8bytes.org> <7446358.Tz4W75qRf1@avalon>
 <20150121150529.GA30345@8bytes.org> <3530276.KVdcG9umfv@avalon>
Message-ID: <20150121152724.GB30345@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 05:07:03PM +0200, Laurent Pinchart wrote:
> As you wish. I just thought you would prefer merging the series with at least 
> one user.

Yes, and with your patch there would be two users: ARM-SMMU and the VMSA
IPMMU. So ideally I would apply/pull Will's patches on v3.19-rc5 with
your patch on-top (and no other patches as dependency).


	Joerg
