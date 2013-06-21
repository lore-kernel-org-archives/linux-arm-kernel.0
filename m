From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 14:57:24 +0200
Subject: [GIT PULL 00/15 v2] Renesas ARM based SoC boot cleanup for v3.11
In-Reply-To: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
References: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <201306211457.24492.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013, Simon Horman wrote:
> Hi Arnd, Olof,
> 
> This pull request is based on renesas-pinmux-for-v3.11, which you have
> already pulled, in order to provide pre-requisites.
> 
> The following changes since commit 5fcf4a3c3a5bc08bf72a50ef1332501a3c1b96bb:
> 
>   ARM: shmobile: marzen: Use RCAR_GP_PIN macro (2013-06-05 17:18:24 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-boot-for-v3.11
> 
> for you to fetch changes up to 53332005bfde9d2e3c9a66030c0e8c2598eaa1d5:
> 
>   ARM: shmobile: Remove Bonito board support (2013-06-17 16:07:31 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM based SoC boot cleanup for v3.11
> 
> Work by Magnus Damm and others to clean up the boot of and move
> things closer to supporting multi-arch.
> 
> As a side effect of this work it was decided to remove support for
> two boards, Bonito and AP4EVB. Those patches are included in this
> series as they depend on earlier patches in the series.

Pulled into next/soc, thanks!

	Arnd
