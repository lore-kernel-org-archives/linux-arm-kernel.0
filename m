From: ralf@linux-mips.org (Ralf Baechle)
Date: Mon, 23 Mar 2015 23:08:07 +0100
Subject: next-20150323 build: 1 failures 23 warnings (next-20150323)
In-Reply-To: <20150323212524.GU14954@sirena.org.uk>
References: <E1YZyoN-00019n-50@debutante>
 <20150323212524.GU14954@sirena.org.uk>
Message-ID: <20150323220806.GB8891@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 02:25:24PM -0700, Mark Brown wrote:

> On Mon, Mar 23, 2015 at 09:38:19AM +0000, Build bot for Mark Brown wrote:
> 
> In current -next the bgmac driver does not compile in an ARM
> allmodconfig:
> 
> > 	arm-allmodconfig
> > ../drivers/net/ethernet/broadcom/bgmac.c:20:27: fatal error: bcm47xx_nvram.h: No such file or directory
> 
> because this include file is only present on MIPS.  This looks at first
> glance to have happened in the merge commit edb15d83a875a1f4 from the
> MIPS tree though I think that needs a bit more investigation.

At that time the bgmac NIC was still exclusivly used on MIPS.

  Ralf
