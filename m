From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:26:58 -0800
Subject: [GIT PULL 00/13] Renesas ARM based SoC Defconfig Updates for v3.15
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <20140220082658.GG19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 03:20:27PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> please consider these Renesas ARM based SoC defconfig updates for v3.15.
> 
> 
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.15
> 
> for you to fetch changes up to 0771ddff31186836f62a20c42e7958bd37f7b4ed:
> 
>   ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig (2014-02-04 10:26:04 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC Defconfig Updates for v3.15
> 
> * Renesas ARM based SoC boards (Global)
>   enable CONFIG_DEVTMPFS in defconfig
> 
> * r8a7791 SoC (R-Car M2) based Koelsch board
>   - Enable SATA
> 
> * r8a7790 SoC (R-Car H2) based Lager board
>   - Enable SATA, VIN and ADV7180 decoder in defconfig
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
> 
> Kuninori Morimoto (9):
>       ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: mackerel: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: lager: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: kzm9g: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: kzm9d: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: genmai: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: bockw: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: armadillo: enable CONFIG_DEVTMPFS in defconfig
>       ARM: shmobile: ape6evm: enable CONFIG_DEVTMPFS in defconfig

Merged into next/boards, but in the future please feel free to squash
down these kind of changes into fewer commits.


-Olof
