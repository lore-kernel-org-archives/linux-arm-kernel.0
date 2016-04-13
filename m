From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 09:42:15 +0200
Subject: [PATCH 04/12] mtd: nand: brcm: rely on generic DT parsing done
 in nand_scan_ident()
In-Reply-To: <20160412223111.GA21705@localhost>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160412223111.GA21705@localhost>
Message-ID: <20160413094215.5f317588@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016 15:31:11 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Fri, Apr 01, 2016 at 02:54:24PM +0200, Boris Brezillon wrote:
> > The core now takes care of parsing generic DT properties in
> > nand_scan_ident() when nand_set_flash_node() has been called.
> > Rely on this initialization instead of calling of_get_nand_xxx()
> > manually.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Acked-by: Brian Norris <computersforpeace@gmail.com>

Applied.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
