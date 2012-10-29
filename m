From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 29 Oct 2012 11:24:35 +0530
Subject: [PATCH 06/16] dma: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
In-Reply-To: <cf922e807ca2ec44837ffc7a320851e9c5272d03.1351411047.git.joe@perches.com>
References: <cover.1351411047.git.joe@perches.com>
 <cf922e807ca2ec44837ffc7a320851e9c5272d03.1351411047.git.joe@perches.com>
Message-ID: <1351490075.7077.36.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-10-28 at 01:05 -0700, Joe Perches wrote:
> dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
> and reducing object size is good.
> Coalesce formats for easier grep. 

Applied thanks

-- 
Vinod Koul
Intel Corp.
