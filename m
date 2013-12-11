From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 11 Dec 2013 17:22:22 -0300
Subject: [PATCH] Partially revert "mtd: nand: pxa3xx: Introduce
 'marvell,armada370-nand' compatible string"
In-Reply-To: <20131209214035.GP10053@titan.lakedaemon.net>
References: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131209214035.GP10053@titan.lakedaemon.net>
Message-ID: <20131211202221.GC5461@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 04:40:35PM -0500, Jason Cooper wrote:
> On Mon, Dec 09, 2013 at 06:36:26PM -0300, Ezequiel Garcia wrote:
> > This reverts c0f3b8643a6fa2461d70760ec49d21d2b031d611.
> > 
> > The "armada370-nand" compatible support is not complete, and it was mistake
> > to add it. Revert it and pospone the support until the infrastructure is
> > in place.
> > 
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 

Brian:

What are your plans regarding this? Where will you be merging it?

As soon as you take this somewhere, I'll send another one adding the
compatible back, for v3.14.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
