From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 23:16:51 +0100
Subject: [GIT PULL]Hisilicon HiX5HD2 soc defconfig udaptes for v3.19
In-Reply-To: <545CBE10.2070502@hisilicon.com>
References: <545CBE10.2070502@hisilicon.com>
Message-ID: <201411192316.52226.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 November 2014, Wei Xu wrote:
> Please help to merge pull request for hisilicon hix5hd2 soc config updates for 3.19. 
> Thanks!
> 
> Best Regards,
> Wei
> 
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
> 
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-config-for-3.19
> 
> for you to fetch changes up to c56a3fbb811d51a810f97a1aca00d37840509b68:
> 
>   ARM: hisi_defconfig: add driver support for hix5hd2 (2014-11-07 19:59:58 +0800)
> 
> ----------------------------------------------------------------
> ARM: HiX5HD2: config update for 3.19
> 
> - Enable GMAC, GPIO, Reset, USB, MMC and SATA on HiX5HD2
> 

Pulled into next/defconfig.

I notice that at least some of the drivers are only enabled in hisi_defconfig
but not in multi_v7_defconfig. Please enable all of them in the generic
multi_v7_defconfig as well, check that it works on your hardware and
send another patch for that. Thanks,

	Arnd
