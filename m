From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 14:54:27 +0100
Subject: [GIT PULL 1/2] part 2 of omap soc changes for v3.19
In-Reply-To: <pull-1416703431-245942>
References: <pull-1416703431-245942>
Message-ID: <201411281454.28102.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 November 2014, Tony Lindgren wrote:
> The following changes since commit 9889278181bcdbae882664d8cee5bb0e064397e4:
> 
>   Merge tag 'for-v3.19/omap-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.19/soc (2014-11-14 10:25:12 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/hwmod-and-defconfig
> 
> for you to fetch changes up to 374a735894fe2fb82ba07c6e6b7d326640c1c17f:
> 
>   ARM: omap2plus_defconfig: enable ECAP and EHRPWM (2014-11-21 16:30:28 -0800)
> 
> ----------------------------------------------------------------
> SoC related changes for omaps including hwmod clean-up for
> DSS, and hwmod data for more UARTs and ADC. Also few defconfig
> changes to enable devices found on am335x and am437x.

Hi Tony,

We have started doing the defconfig changes in a separate branch a while ago.
I normally don't mess with the tags I got, but this one seemed easy enough
to redo, as the defconfig changes are all on top.

I ended up pulling in only the commits before the defconfig changes into
next/soc, and am cherry-picking the defconfig bits onto the next/defconfig
branch. Hope that's ok for you.

I checked that the defconfig changes are all harmless and do not depend
on the other changes, but I may have missed something subtle, so please
confirm that this is ok for you.

Thanks,

	Arnd
