From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 21 Nov 2016 12:01:56 +0100
Subject: [PATCH] mtd: nand: tango: Use nand_to_mtd() instead of directly
 accessing chip->mtd
In-Reply-To: <5832C579.10101@sigmadesigns.com>
References: <1479718984-26491-1-git-send-email-boris.brezillon@free-electrons.com>
 <5832C579.10101@sigmadesigns.com>
Message-ID: <20161121120156.51d5f710@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Nov 2016 10:59:21 +0100
Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:

> On 21/11/2016 10:03, Boris Brezillon wrote:
> 
> > The nand_to_mtd() helper is here to hide internal mtd_info <-> nand_chip
> > association and ease future refactors.
> > 
> > Make use of this helper instead of directly accessing chip->mtd.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/mtd/nand/tango_nand.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)  
> 
> Acked-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Applied.

Thanks,

Boris

> 
> Regards.
> 
