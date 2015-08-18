From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 18 Aug 2015 11:28:40 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Unmap and free table when
 overwriting with block
In-Reply-To: <1439308112-29758-1-git-send-email-will.deacon@arm.com>
References: <1439308112-29758-1-git-send-email-will.deacon@arm.com>
Message-ID: <20150818092840.GA26556@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 04:48:32PM +0100, Will Deacon wrote:
> Joerg, could you queue this up for 4.3 please? It's a fix, but it's late
> in the day for 4.2 and doesn't backport cleanly. Merging it with the Cc
> stable tag is probably the easiest thing to do, then I can fix up the
> conflicts as they arise.

Applied, thanks Will.
