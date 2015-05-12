From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 17:05:17 +0200
Subject: [GIT PULL]Hisilicon hip04 soc defconfig updates for v4.2
In-Reply-To: <554CC95E.2060701@hisilicon.com>
References: <554CC95E.2060701@hisilicon.com>
Message-ID: <2377043.muyzvjXoX2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 15:34:06 Wei Xu wrote:
> ARM: HIP04: configure updates for 4.2
> 
> - Enable ethernet on hip04 SoC
> - Enable Sysnopsis GPIO controller on hip04 SoC
> 

Pulled into next/defconfig. Can you please send another update that adds the
drivers as loadable modules to the multi_v7_defconfig file?

We should make sure that all ARMv7 platforms we support work with
multi_v7_defconfig as well.

	Arnd
