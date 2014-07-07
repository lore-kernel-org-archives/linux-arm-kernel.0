From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Jul 2014 17:49:35 -0700
Subject: [GIT PULL 3/3] ARM: tegra: use us counter as delay timer
In-Reply-To: <1403558626-13422-3-git-send-email-swarren@wwwdotorg.org>
References: <1403558626-13422-1-git-send-email-swarren@wwwdotorg.org>
 <1403558626-13422-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140707004935.GF8469@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 03:23:46PM -0600, Stephen Warren wrote:
> Tegra has a micro-second counter whose rate doesn't vary with cpufreq
> changes. Register it so it can be used as the delay timer, so delays
> aren't influenced by cpufreq.
> 
> I've made this a separate branch since it touches a few files outside
> arch/arm/mach-tegra/. This can be merged anywhere that conflicts need
> to be resolved, although I know of no such places at present.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:
> 
>   Linux 3.16-rc1
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.17-delay-timer

I didn't see an ack from clocksource maintainer on that patch, make
sure you get them in the future. I'll take a risk and merge it anyway
this time; the change is fairly well-contained.

Merged into next/soc.


-Olof
