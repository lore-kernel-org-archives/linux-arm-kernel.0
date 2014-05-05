From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 May 2014 22:21:08 -0700
Subject: [GIT PULL] somewhat urgent omap fixes against v3.15-rc1, fixes
 gpmc
In-Reply-To: <20140425203047.GG20807@atomide.com>
References: <20140425203047.GG20807@atomide.com>
Message-ID: <20140505052108.GC16022@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 01:30:48PM -0700, Tony Lindgren wrote:
> The following changes since commit fb677ef70b65e22cd4401d31b700a8b4041efae1:
> 
>   ARM: OMAP2+: Fix GPMC remap for devices using an offset (2014-04-23 11:09:22 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.15/fixes-gpmc
> 
> for you to fetch changes up to 4c05160342f16361fc37ae34dcae9210306a83e9:
> 
>   ARM: dts: AM3517: Disable absent IPs inherited from OMAP3 (2014-04-25 09:55:00 -0700)
> 
> ----------------------------------------------------------------
> Mostly fixes for occasional memory corruption caused by bad
> timings for smc911x LAN9220 (and potentially LAN9221) devices
> that were noted on a cm-t3730 system. Also fix THUMB mode
> for SMP, and mailbox related warnings when booted with device
> tree.

Merged into fixes.


-Olof
