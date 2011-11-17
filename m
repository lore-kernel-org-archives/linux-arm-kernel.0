From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Nov 2011 23:13:59 +0200
Subject: Missing patches for pxa3xx_nand
In-Reply-To: <4EB7C084.4060706@gmail.com>
References: <4EB7C084.4060706@gmail.com>
Message-ID: <1321564441.2272.1.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-11-07 at 12:27 +0100, Daniel Mack wrote:
> Hi,
> 
> In June, there have been important patches submitted for the pxa3xx_nand 
> driver after it was broken by Lei's rework series. These patches were 
> discussed in June, and they are present in
> 
>    git://git.infradead.org/mtd-2.6.git linux-fallback
> 
> but not in the master branch of the same git. Also, they have not been 
> merged to Linus' master tree which renders the pxa3xx_nand driver 
> unusable in 3.0 and 3.1.
> 
> A selection of the patches I'm talking about are titled
> 
>    mtd: pxa3xx_nand: Fix blank page ECC mismatch
>    mtd: pxa3xx_nand: fix nand detection issue
>    mtd: pxa3xx_nand don't specify default parsing options

All three patches have been merged upstreem, you should have looked at
the l2-mtd-2.6.git tree or linux-next as well.

Artem.
