From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 10:38:13 -0700
Subject: [GIT PULL 1/2] Rockchip soc changes for 4.3, part1
In-Reply-To: <8030973.PEt4S6scyC@diego>
References: <2820374.NgluYWXZkW@diego>
 <8030973.PEt4S6scyC@diego>
Message-ID: <20150717173813.GM21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 12:35:47AM +0200, Heiko St?bner wrote:
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.3-rockchip32-soc1
> 
> for you to fetch changes up to cb8cc37f4d38d96552f2c52deb15e511cdacf906:
> 
>   ARM: rockchip: fix broken build (2015-07-06 11:46:08 +0200)
> 
> ----------------------------------------------------------------
> Some suspend improvements enabling the possibility to wakeup
> from usbphy events and a rework of how cpu cores are brought
> u? and down, as it was possible to produce lockups when
> hammering the cpu hotplug functions.

Thanks, merged.


-Olof
