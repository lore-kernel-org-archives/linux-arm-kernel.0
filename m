From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2016 16:54:41 -0700
Subject: [GIT PULL] omap-gpmc fixes for v4.8-rc1
In-Reply-To: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
References: <a4bd1d47-87b1-9ef9-d9d1-6c69be404b9e@ti.com>
Message-ID: <20160825235441.GB6209@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 10:53:30AM +0300, Roger Quadros wrote:
> Hi Arnd/Olof,
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rogerq/linux.git tags/gpmc-omap-v4.8-rc1
> 
> for you to fetch changes up to 23540d6e2f3193b946c4de43e3f9654fa6d23fe7:
> 
>   memory: omap-gpmc: allow probe of child nodes to fail (2016-08-08 11:18:40 +0300)
> 
> ----------------------------------------------------------------
> OMAP-GPMC: fixes for v4.8-rc1
> 
> * Allow other children of GPMC to probe even if any child fails.
> This fixes problem on Overo boards where networking device child
> doesn't probe due to broken NAND child.

Merged, thanks.


-Olof
