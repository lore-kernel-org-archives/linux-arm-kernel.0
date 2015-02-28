From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 28 Feb 2015 01:28:08 -0800
Subject: [PATCH v2 01/10] mtd: pxa3xx_nand: initialiaze pxa3xx_flash_ids
 to 0
In-Reply-To: <1423752816-26219-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423752816-26219-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150228092808.GC12966@brian-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 03:53:27PM +0100, Antoine Tenart wrote:
> pxa3xx_flash_ids wasn't initialized to 0, which in certain cases could
> end up containing corrupted values in its members. Fix this to avoid
> possible issues.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Applied this patch to l2-mtd.git. The others are TBD still. (Haven't
examined all of them too closely.)

Brian
