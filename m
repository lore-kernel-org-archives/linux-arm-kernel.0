From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 31 Jan 2013 07:51:16 -0500
Subject: [GIT PULL] ARM: mvebu cleanup for v3.9 round2
In-Reply-To: <1359495436.F88c4680.7559@triton>
References: <1359495436.F88c4680.7559@triton>
Message-ID: <20130131125116.GC7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Please don't pull this yet.  The nsa310 patch built fine at the tip of
my for-next, but didn't do so well when applied to mvebu/cleanup.

I'll redo and resubmit the whole series of pr's.

thx,

Jason.

On Tue, Jan 29, 2013 at 09:37:16PM +0000, Jason Cooper wrote:
> The following changes since commit b96e1b1c3c5319294edb0970b6d5bf099c0e85eb:
> 
>   ARM: Kirkwood: Cleanup unneeded include files (2013-01-12 21:50:10 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.9_round2
> 
> for you to fetch changes up to 63a069739a5826ab4007da88b7ec71eb9909271c:
> 
>   ARM: dove: cleanup includes (2013-01-29 21:31:36 +0000)
> 
> ----------------------------------------------------------------
> cleanup for v3.9 round2
>  - remove unneeded #includes for mach-dove
>  - remove unneeded #includes and code for the nsa310
> 
> ----------------------------------------------------------------
> Jason Cooper (1):
>       ARM: kirkwood: nsa310: cleanup includes and unneeded code
> 
> Sebastian Hesselbarth (1):
>       ARM: dove: cleanup includes
> 
>  arch/arm/mach-dove/common.c           | 29 +++++++++--------------------
>  arch/arm/mach-kirkwood/board-nsa310.c |  9 +--------
>  2 files changed, 10 insertions(+), 28 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
