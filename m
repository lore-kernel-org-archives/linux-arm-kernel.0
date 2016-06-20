From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jun 2016 14:42:00 +0100
Subject: next-20160620 build: 2 failures 9 warnings (next-20160620)
In-Reply-To: <E1bEwGe-0004DR-4p@optimist>
References: <E1bEwGe-0004DR-4p@optimist>
Message-ID: <20160620134200.GU26099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 11:17:20AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build due to:

> 	arm64-allmodconfig
> ../drivers/iommu/mtk_iommu.c:27:32: fatal error: linux/of_component.h: No such file or directory

which is triggered by da4d6e6d3b3ef (iommu/mediatek: Convert DT
component matching to component_match_add_release()) - there is
presumably a dependency on some other patch series that is still in
review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160620/c9fc8ac5/attachment.sig>
