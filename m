From: axboe@fb.com (Jens Axboe)
Date: Mon, 12 Oct 2015 13:10:17 -0600
Subject: [PATCH v2] nvme: fix 32-bit build warning
In-Reply-To: <20151012190339.GA31736@lst.de>
References: <5851501.PBMrs03XFb@wuerfel>
 <20151009144221.GA12760@infradead.org> <6199457.Ih8H4dRbvg@wuerfel>
 <20151012190339.GA31736@lst.de>
Message-ID: <561C0599.1090904@fb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2015 01:03 PM, Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Note that we're moved the nvme driver to a new directory in the
> block tree, but I can rebase it for you if you want.

I man handled it on both branches, so we should be good.


-- 
Jens Axboe
