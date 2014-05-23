From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 24 May 2014 00:48:23 +0200
Subject: [GIT PULL] ARM: mach-bcm: soc updates for 3.16
In-Reply-To: <20140523131143.GA24064@beef>
References: <20140523131143.GA24064@beef>
Message-ID: <201405240048.24187.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 May 2014, Matt Porter wrote:
> Please consider pulling the following mach-bcm soc updates for 3.16.
> 
> -Matt
> 
> The following changes since commit eeda4cb92ee0fb63a5917738e107b0bc8168079e:
> 
>   ARM: bcm: rename "kona.h" and "kona.c" (2014-04-25 08:51:38 -0400)
> 
> are available in the git repository at:
> 
>   git://github.com/broadcom/mach-bcm tags/for-3.16/bcm-soc
> 
> for you to fetch changes up to 387468d190f0ba72e239c11e9663cfeaeaf9ae2d:
> 
>   ARM: bcm_defconfig: Enable PWM and Backlight (2014-04-28 11:10:29 -0400)
> 
> ----------------------------------------------------------------
> mach-bcm 3.16 soc updates:
> 
> * only show ARCH_BCM in multi v6/v7 configs
> * enable ARM erratum 775420
> * bcm_defconfig updates for pwm
> 

Merged into next/soc, thanks!

	Arnd
