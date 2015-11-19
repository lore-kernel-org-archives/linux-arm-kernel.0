From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 19 Nov 2015 11:22:07 -0800
Subject: [PATCH 03/27] mtd: nand: update examples in the documentation to
 use mtd_to_nand()
In-Reply-To: <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151119192207.GG64635@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 02:37:36PM +0100, Boris Brezillon wrote:
> mtd_to_nand() has been introduced to hide accesses to mtd->priv.
> All NAND controller drivers should use it instead of directly accessing
> the ->priv field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Pushed to l2-mtd.git
