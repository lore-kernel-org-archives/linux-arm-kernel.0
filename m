From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 16:53:52 +0200
Subject: [PATCH 10/12] mtd: nand: pxa3xx: rely on generic DT parsing
 done in nand_scan_ident()
In-Reply-To: <20160413144822.GA1065@laptop.cereza>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459515272-31011-11-git-send-email-boris.brezillon@free-electrons.com>
 <20160413144822.GA1065@laptop.cereza>
Message-ID: <20160413165352.37915109@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Apr 2016 11:48:22 -0300
Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:

> On 01 Apr 02:54 PM, Boris Brezillon wrote:
> > The core now takes care of parsing generic DT properties in
> > nand_scan_ident() when nand_set_flash_node() has been called.
> > Rely on this initialization instead of calling of_get_nand_xxx()
> > manually.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Acked-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Applied.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
