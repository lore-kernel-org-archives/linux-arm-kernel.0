From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 Sep 2014 22:45:38 +0200
Subject: [PATCH 0/3] ARM: Meson6: enable SMP
In-Reply-To: <2970330.BJMVixgoJ1@wuerfel>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
 <20140930084646.GA31027@carlo-MacBookPro>
 <2970330.BJMVixgoJ1@wuerfel>
Message-ID: <20140930204538.GA6985@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mar, set 30, 2014 at 12:22:21 +0200, Arnd Bergmann wrote:
> On Tuesday 30 September 2014 10:46:46 Carlo Caione wrote:
> > On mar, set 30, 2014 at 10:43:52 +0200, Carlo Caione wrote:
> > > Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> > > pieces to boot the secondary CPU.
> > 
> > Sorry for the double sending.
> > Forgot to CC LAKML.
> 
> Looks good to me in principle, but I wonder about the CPU enable method.
> Are you able to implement PSCI in u-boot like it was done for allwinner?
> 
> This is mostly a question of whether the system comes up in secure mode
> or non-secure mode.

I would be able if I had the u-boot source code or the possibility to
flash the board I'm using. Unfortunately at this moment I don't have
either. Probably in the near future I'll be able to implement PSCI in
u-boot since Amlogic is kindly starting to provide documentation but now
this is the best I can do.

-- 
Carlo Caione
