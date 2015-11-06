From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Nov 2015 11:42:01 +0000
Subject: [PATCH v5 3/6] iommu: add ARM short descriptor page table
 allocator
In-Reply-To: <1446799372.6400.28.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <1444357388-30257-4-git-send-email-yong.wu@mediatek.com>
 <1446799372.6400.28.camel@mhfsdcap03>
Message-ID: <20151106114200.GF6087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 04:42:52PM +0800, Yong Wu wrote:
> On Fri, 2015-10-09 at 10:23 +0800, Yong Wu wrote:
> > This patch is for ARM Short Descriptor Format.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> 
> Hi Will, Robin,
>    Is there any comment about this patch?
>    As our project request, We are going to prepare the next version.

Robin has been looking at the code after he ran into problems using it
in conjunction with arm-smmu. I'd expect him to post something after the
merge window, so you may as well hold-off until then.

Will
