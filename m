From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 14:09:37 +0200
Subject: linux-next: manual merge of the arm-soc tree with the xilinx tree
In-Reply-To: <CAHTX3d+NK7b3RVMASZ4BARs1kHeVKGgxNwKTjAeiNB+44TPsFg@mail.gmail.com>
References: <20130405153335.baf29606a97b1bee415f3546@canb.auug.org.au>
 <CAHTX3d+NK7b3RVMASZ4BARs1kHeVKGgxNwKTjAeiNB+44TPsFg@mail.gmail.com>
Message-ID: <201304051409.37708.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Michal Simek wrote:
> Hi,
> 
> 2013/4/5 Stephen Rothwell <sfr@canb.auug.org.au>
> 
> > Hi all,
> >
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-spear/spear13xx.c between commit c79e33b3e828 ("ARM:
> > smp_twd: convert to use CLKSRC_OF init") from the xilinx tree and commit
> > 2b9c613c4ee1 ("ARM: spear: move generic.h and pl080.h into private dir")
> > from the arm-soc tree.
> >
> > I fixed it up (just used the arm-soc tree version) and can carry the fix
> > as necessary (no action is required).
> >  <sfr@canb.auug.org.au>
> 
> 
> Interesting. I rebased my arm-next branch based on 3.9-rc5
> with some Rob's + one Arnd patch from arm-soc - clksrc/cleanup branch.
> 
> I will fix my arm-next branch.

The for-next branch in arm-soc is not stable, you should never base
/anything/ on it. If you depend on some stable branch, that is in arm-soc,
then use just that branch, not one of the next/* branches or for-next.

	Arnd
