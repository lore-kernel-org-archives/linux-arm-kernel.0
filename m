From: tony@atomide.com (Tony Lindgren)
Date: Fri, 15 Mar 2013 09:24:16 -0700
Subject: [GIT PULL] ARM: omap2: twl-common update
In-Reply-To: <5142E376.9080407@ti.com>
References: <5142E376.9080407@ti.com>
Message-ID: <20130315162416.GC9370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130315 02:05]:
> Hi Tony,
> 
> The branch is on top of today's mainline.
> Is it still possible to send this for 3.9?

It seems that fixing reboot is a good reason to try to merge it during
the -rc cycle. Is this a regression? If so it should mention what broke
it.

Also please base this on a recent mainline tag like v3.8 or v3.9-rc2..
 
> The following changes since commit a2362d24764a4e9a3187fc46b14e1d2cd0657700:
> 
>   mm/fremap.c: fix possible oops on error path (2013-03-14 17:00:39 -0700)

..as this commit seems to be a random base and might cause confusion that
there's some dependency to that patch.

Regards,

Tony
 
> are available in the git repository at:
> 
>   git://gitorious.org/omap-audio/linux-audio.git peter/upstream/for-tony
> 
> for you to fetch changes up to 25d28e7988512eb4964eca5fc54a214ae69a7154:
> 
>   omap2: twl-common: Add default power configuration (2013-03-15 09:59:28 +0100)
> 
> ----------------------------------------------------------------
> Matthias Brugger (1):
>       omap2: twl-common: Add default power configuration
> 
>  arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/twl-common.h |  1 +
>  2 files changed, 39 insertions(+)
