From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:46:39 -0800
Subject: [GIT_PULL 2/3] ARM: Keystone config for 4.11
In-Reply-To: <1485039758-15248-2-git-send-email-ssantosh@kernel.org>
References: <1485039758-15248-1-git-send-email-ssantosh@kernel.org>
 <1485039758-15248-2-git-send-email-ssantosh@kernel.org>
Message-ID: <20170129224639.GG3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 03:02:37PM -0800, Santosh Shilimkar wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_config_for_4.11
> 
> for you to fetch changes up to a2735c3067e7c25c46433c1d73b97d4d4e512de8:
> 
>   ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER (2017-01-19 09:36:08 -0800)
> 
> ----------------------------------------------------------------
> ARM: Keystone config support for 4.11
> 
> 	- Enable Reset controller and on chip MSM RAM support.
> 
> ----------------------------------------------------------------
> Suman Anna (2):
>       ARM: configs: keystone: Enable Generic on-chip SRAM driver
>       ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER

If you had other bpatches for arch/arm/mach-*, I'd group the latter into the
same branch as that. Anyway, not a huge deal on just an off patch like this.

Merged into next/defconfig.


-Olof
