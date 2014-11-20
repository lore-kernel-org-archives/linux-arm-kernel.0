From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:12:00 +0100
Subject: [GIT PULL 3.19] Broadcom Cygnus SoC defconfig
In-Reply-To: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
References: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201411201312.00243.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Florian Fainelli wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/arm-soc/for-3.19/cygnus-defconfig-v2
> 
> for you to fetch changes up to b316a9f98a2e328d10f5ed3c341fa28880152af3:
> 
>   ARM: bcm_defconfig: remove one level of menu from Kconfig (2014-11-11 22:42:05 -0800)
> 
> ----------------------------------------------------------------
> This pull requests removes one level in menuconfig for the BCM SoCs for the
> bcm_defconfig file.
> 
> ----------------------------------------------------------------
> Scott Branden (1):
>       ARM: bcm_defconfig: remove one level of menu from Kconfig
> 
>  arch/arm/configs/bcm_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

After taking a closer look, I ended up putting this into next/soc as well,
not next/defconfig, since the change has a mutual dependency on the Kconfig
change in that branch.

	Arnd
