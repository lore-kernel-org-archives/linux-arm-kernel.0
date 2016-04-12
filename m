From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 12 Apr 2016 15:31:11 -0700
Subject: [PATCH 04/12] mtd: nand: brcm: rely on generic DT parsing done
 in nand_scan_ident()
In-Reply-To: <1459515272-31011-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412223111.GA21705@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 02:54:24PM +0200, Boris Brezillon wrote:
> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>
