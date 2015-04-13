From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 00:47:35 +0200
Subject: [GIT PULL] Broadcom SoC changes for 4.1
In-Reply-To: <1428692730-18529-1-git-send-email-f.fainelli@gmail.com>
References: <1428692730-18529-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201504140047.35908.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 April 2015, Florian Fainelli wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   http://github.com/broadcom/stblinux tags/arm-soc/for-4.1/soc
> 
> for you to fetch changes up to 3213e674ca42c95b84ed040eab3d5722f41412ae:
> 
>   ARM: cygnus: fix const declaration bcm_cygnus_dt_compat (2015-03-24 15:13:23 -0700)
> 
> ----------------------------------------------------------------
> Trivial change to fix a const declaration for the Cygnus SoC
> 
> ----------------------------------------------------------------
> Stefan Agner (1):
>       ARM: cygnus: fix const declaration bcm_cygnus_dt_compat
> 
>  arch/arm/mach-bcm/bcm_cygnus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Pulled into next/soc, thanks!

	Arnd
