From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:11:14 +0100
Subject: [GIT PULL 3.19] Broadcom Cygnus SoC platform support
In-Reply-To: <1415826266-6867-4-git-send-email-f.fainelli@gmail.com>
References: <1415826266-6867-1-git-send-email-f.fainelli@gmail.com>
 <1415826266-6867-4-git-send-email-f.fainelli@gmail.com>
Message-ID: <201411201311.14549.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Florian Fainelli wrote:
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/brcm/linux.git tags/arm-soc/for-3.19/cygnus-platform-v2
> 
> for you to fetch changes up to 64e74aa788f996cd0e328a1c4223e9d438b78e9c:
> 
>   ARM: mach-bcm: ARCH_BCM_MOBILE: remove one level of menu from Kconfig (2014-11-11 22:35:45 -0800)
> 
> ----------------------------------------------------------------
> This pull request contains the platform code to support the Broadcom Cygnus SoC
> using the iProc architecture:
> 
> - add support for the Broadcom Cygnus SoC
> - consolidate the BCM5301X Kconfig options under the iProc menuconfig entry
> - remove one level of menu in menuconfig
> 
> ----------------------------------------------------------------
> Jonathan Richardson (1):
>       ARM: cygnus: Initial support for Broadcom Cygnus SoC
> 
> Scott Branden (2):
>       ARM: mach-bcm: Consolidate currently supported IPROC SoCs
>       ARM: mach-bcm: ARCH_BCM_MOBILE: remove one level of menu from Kconfig
> 
>  arch/arm/mach-bcm/Kconfig      | 93 ++++++++++++++++++++++++++----------------
>  arch/arm/mach-bcm/Makefile     |  3 ++
>  arch/arm/mach-bcm/bcm_cygnus.c | 25 ++++++++++++
>  3 files changed, 85 insertions(+), 36 deletions(-)
>  create mode 100644 arch/arm/mach-bcm/bcm_cygnus.c
> 

Pulled into next/soc, thanks!

	Arnd
