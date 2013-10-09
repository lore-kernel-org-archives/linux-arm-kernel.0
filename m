From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Oct 2013 08:48:04 -0700
Subject: [PATCHv8 00/36] ARM: OMAP: DT clock conversion
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Message-ID: <20131009154804.GB8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131009 08:40]:
> 
> Separate branches for the maintainers also available here:
> 
> https://github.com/t-kristo/linux-pm.git
> 
> Branch with DTS only data: 3.12-rc3-dt-clks-for-benoit
> - based on top of 3.12-rc3 with Benoit's latest for_3.13 merged in
> 
> Branch with clock driver patches: 3.12-rc3-dt-clks-for-mike
> - based on top of 3.12-rc3
> - does not compile due to lack of 1 dependency patch (for getting DT clock
>   parent count) which Mike has queued to his own branch though I believe

Maybe Mike can provide you an immutable commit on which
to base your 3.12-rc3-dt-clks-for-mike?
 
> Branch with all the stuff for mach-omap2: 3.12-rc3-dt-clks-for-tony
> - based on top of 3.12-rc3
> - merged both above branches to this
> - merged also a few temporary hacks to get some of my boards to work,
>   these have been discussed elsewhere but can act as a reference

I suggest you keep those temporary hacks in yet another
temporary branch until I have some immutable commit with the hwmod
changes etc pulled into in it. Then ideally you won't have to change
your for-tony branch and it can be just merged on top of the branch
with the dependencies.

Regards,

Tony
