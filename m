From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 21:57:26 -0800
Subject: [GIT PULL V2 1/4] ARM: mvebu: cleanup for v3.9
In-Reply-To: <1358909283.6D1c74D1.21555@triton>
References: <pull-1358909291-876385>
 <1358909283.6D1c74D1.21555@triton>
Message-ID: <20130128055726.GB25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 02:48:03AM +0000, Jason Cooper wrote:
> The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:
> 
>   Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.9
> 
> for you to fetch changes up to b96e1b1c3c5319294edb0970b6d5bf099c0e85eb:
> 
>   ARM: Kirkwood: Cleanup unneeded include files (2013-01-12 21:50:10 +0000)
> 
> ----------------------------------------------------------------
> mvebu cleanup for v3.9
>  - remove unneeded includes due to DT conversion
> 
> ----------------------------------------------------------------
> Andrew Lunn (1):
>       ARM: Kirkwood: Cleanup unneeded include files
> 
> Thomas Petazzoni (1):
>       arm: kirkwood: dockstar: remove useless include of SDIO header
> 
>  arch/arm/mach-kirkwood/board-ib62x0.c   | 1 -
>  arch/arm/mach-kirkwood/board-mplcec4.c  | 1 -
>  arch/arm/mach-kirkwood/dockstar-setup.c | 1 -
>  3 files changed, 3 deletions(-)

Hi,

This one I pulled as mvebu/cleanup. I'm holding off on the others based
on my reply, since the drivers branch is base for the later branches.


-Olof
