From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 15:51:27 +0200
Subject: [PATCH 02/12] mtd: nand: atmel: rely on generic DT parsing done
 in nand_scan_ident()
In-Reply-To: <1459515272-31011-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160413155127.652fdfb4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  1 Apr 2016 14:54:22 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> The core now takes care of parsing generic DT properties in
> nand_scan_ident() when nand_set_flash_node() has been called.
> Rely on this initialization instead of calling of_get_nand_xxx()
> manually.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Applied.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
