From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 21:03:39 +0200
Subject: [PATCH v2] nvme: fix 32-bit build warning
In-Reply-To: <6199457.Ih8H4dRbvg@wuerfel>
References: <5851501.PBMrs03XFb@wuerfel>
 <20151009144221.GA12760@infradead.org> <6199457.Ih8H4dRbvg@wuerfel>
Message-ID: <20151012190339.GA31736@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Note that we're moved the nvme driver to a new directory in the
block tree, but I can rebase it for you if you want.
