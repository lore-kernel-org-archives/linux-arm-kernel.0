From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 15:27:49 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Sh73a0 Multiplatform Updates for
 v3.20
In-Reply-To: <20150116124416.GB6285@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
 <1524412.qzMh8qoUQG@wuerfel> <20150116124416.GB6285@verge.net.au>
Message-ID: <1624379.BZHQTL5QDD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 21:44:16 Simon Horman wrote:
> On Fri, Jan 16, 2015 at 09:38:44AM +0100, Arnd Bergmann wrote:
> > I see that after this pull request, only ARCH_SH7372 and ARCH_R8A7778
> > are left without multiplatform support. Did I remember correctly
> > that you plan to add a common clock driver for ARCH_R8A7778 next,
> > move that to multiplatform and then delete all the ARCH_SHMOBILE_LEGACY
> > support including ARCH_SH7372?
> 
> Hi Arnd,
> 
> yes, my understanding is that is (still) the plan.

Ok, thanks for the confirmation. 

	Arnd
