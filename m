From: jesper.nilsson@axis.com (Jesper Nilsson)
Date: Tue, 9 Jan 2018 16:54:54 +0100
Subject: [PATCH 22/67] dma-mapping: clear harmful GFP_* flags in common
 code
In-Reply-To: <20171229081911.2802-23-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-23-hch@lst.de>
Message-ID: <20180109155454.GO32368@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 29, 2017 at 09:18:26AM +0100, Christoph Hellwig wrote:
> Life the code from x86 so that we behave consistently.  In the future we
> should probably warn if any of these is set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/arch-v32/drivers/pci/dma.c      | 3 ---

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson at axis.com
