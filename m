From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 22:08:49 -0800
Subject: [GIT PULL 2/2] Broadcom defconfig fixes for 4.10
In-Reply-To: <20170115023637.24759-1-f.fainelli@gmail.com>
References: <20170115023637.24759-1-f.fainelli@gmail.com>
Message-ID: <20170117060849.GE16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 06:36:36PM -0800, Florian Fainelli wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.10/defconfig-fixes
> 
> for you to fetch changes up to 91546c56624a79f4a8fd80bede6b5a38c0f0ad78:
> 
>   ARM: multi_v7_defconfig: set bcm47xx watchdog (2017-01-12 16:03:12 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains fixes to multi_v7_defconfig for Broadcom ARM-based
> SoCs, please pull the following changes:
> 
> - Valenting fixes two incorrect Kconfig symbols for BCM47xx: NVRAM and watchdog drivers
> 
> ----------------------------------------------------------------
> Valentin Rothberg (2):
>       ARM: multi_v7_defconfig: fix config typo
>       ARM: multi_v7_defconfig: set bcm47xx watchdog

Merged. How did we even get here? Did the options rename or did someone
edit config files by hand?


-Olof
