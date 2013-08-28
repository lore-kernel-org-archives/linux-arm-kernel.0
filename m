From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:44:34 +0900
Subject: [GIT PULL 0/5] Third round of Renesas ARM-based SoC board
 updates for v3.12
In-Reply-To: <cover.1377653181.git.horms+renesas@verge.net.au>
References: <cover.1377653181.git.horms+renesas@verge.net.au>
Message-ID: <20130828014432.GA1763@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 10:37:40AM +0900, Simon Horman wrote:
> Hi Kevin, Hi Olof, Hi Arnd,
> 
> please consider this third round of Renesas ARM based SoC board
> updates for v3.12.

I inadvertently sent this email twice.
Sorry for any confusion that may cause.
The contents should be identical.

> 
> It is based on a merge of:
> 
> * renesas-boards2-for-v3.12
>   ("Second Round of ARM based SoC board updates for v3.12")
>   which you have previously pulled.
> 
> * renesas-boards-cleanup-for-v3.12
>   ("ARM based SoC board cleanups updates for v3.12")
>   which you have previously pulled.
> 
> * git://people.freedesktop.Org/~airlied/linux drm-rcar-for-v3.12
>   Which is in turn based on v3.11-rc3.
>   This was provided by Dave Airlie to provide dependencies
>   for the Display Unit changes in this series.
> 
> I encountered a minor merge conflict when I merged this branch into
> my own next branch. My resolution is available in the renesas-next-20130823
> tag of my renesas tree.
> 
> I apologise that this and other pull requests that I will send today
> are rather later in the cycle than I would like. This is primarily due
> to a combination of my summer vacation and wanting to let the patches
> sit in next for a while.
> 
> 
> The following changes since commit 3ddace5bccc5094a1d135fe4a9e555ef1d40006c:
> 
>   Merge branch 'drm-rcar-for-v3.12' of git://people.freedesktop.Org/~airlied/linux into boards3 (2013-08-22 11:11:55 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards3-for-v3.12
> 
> for you to fetch changes up to 8034dc4a1d615c84932c74633b7399603f7cc2a4:
> 
>   ARM: shmobile: lager: Fix Display Unit platform data (2013-08-23 09:14:16 +0900)
> 
> ----------------------------------------------------------------
> Third round of Renesas ARM-based SoC board updates for v3.12
> 
> * Add Display Unit support to lager and marzen boards
> * Constify platform data and resources of lager board
> * Correct regulators of  MMC0, SDHI0 and SDHI1 on ape6evm board
> 
> ----------------------------------------------------------------
> Guennadi Liakhovetski (1):
>       ARM: shmobile: ape6evm: update MMC0, SDHI0 and SDHI1 with correct regulators
> 
> Laurent Pinchart (4):
>       ARM: shmobile: marzen: Add Display Unit support
>       ARM: shmobile: lager: Constify platform data and resources
>       ARM: shmobile: lager: Add Display Unit support
>       ARM: shmobile: lager: Fix Display Unit platform data
> 
>  arch/arm/mach-shmobile/board-ape6evm.c | 54 +++++++++++++++++++----
>  arch/arm/mach-shmobile/board-lager.c   | 80 +++++++++++++++++++++++++++++++---
>  arch/arm/mach-shmobile/board-marzen.c  | 72 ++++++++++++++++++++++++++++++
>  3 files changed, 191 insertions(+), 15 deletions(-)
> 
