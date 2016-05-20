From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2016 21:01:24 +0200
Subject: [GIT PULL 0/7] ARM: SoC changes for 4.7
In-Reply-To: <87eg8xj018.fsf@belgarion.home>
References: <8749147.ztcb6kVhye@wuerfel> <87eg8xj018.fsf@belgarion.home>
Message-ID: <201605202101.24832.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 May 2016, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> .. zip ... removed Linux and lkml as this is pxa specific.
> 
> > Hi Linus,
> >
> > These are the first seven pull requests for arm-soc this time, there is
> > one small follow-up coming once the dependencies for that have landed
> > in your tree.
> I was wondering if my pull requests will be part of this follow-up ?
> I'm speaking of :
>  - https://patchwork.ozlabs.org/patch/617118/
>  - https://patchwork.ozlabs.org/patch/617119/ 
>
Hmm, no they were not part of this.

> Even if from my persespective passing this cycle doesn't matter much, I don't
> know if this matters to Stephen as CLK_IS_ROOT will remain one more cycle.

I'm very sorry I completely missed the pull requests. I've the first one in the
fixes branch now, so it should be in v4.7rc1 after all.

I also considered pulling the second branch into late/next, as it looks small
and harmless and you did send it in time, but as you say here it's not really
urgent either.	Just let me know if you want me to pick up "
ARM: dts: pxa: fix the ohci clock for pxa3xx" in the fixes branch as well,
I can cherry-pick the commit directly.

	Arnd
