From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 23:13:55 +0100
Subject: [GIT PULL]Hisilicon HiX5HD2 soc DT udaptes for v3.19
In-Reply-To: <545CBD40.7060003@hisilicon.com>
References: <545CBD40.7060003@hisilicon.com>
Message-ID: <201411192313.55636.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014, Wei Xu wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-dt-for-3.19
> 
> for you to fetch changes up to 92cfcb26fca45aafa7eb9b8a4401a361caa88dec:
> 
>   ARM: dts: hix5hd2: add reboot node (2014-11-07 19:29:53 +0800)
> 
> ----------------------------------------------------------------
> ARM: DT:  Hisilicon terminal SoC HiX5HD2 DT updates for 3.19
> 
> - Add reboot node, reusing syscon-reboot
> - Add I2C nodes Hisilicon IP
> - Add IR node based on Hisilicon IP
> - Add Watchdog node based on ARM IP
> - Add GPIO nodes based on ARM GPIO IP
> - Add SATA node based on Hisilicon IP
> - Add USB nodes
> - Add MMC nodes based on Synopsys IP
> - Add GMAC nodes based on Hisilicon IP

Pulled into next/dt, sorry for the delay,

	Arnd
