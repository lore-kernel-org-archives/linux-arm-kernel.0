From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:22:57 +0900
Subject: [PATCH 02/05] ARM: shmobile: Use KZM9D without reference for
 multiplatform
In-Reply-To: <20131001103315.813.80581.sendpatchset@w520>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103315.813.80581.sendpatchset@w520>
Message-ID: <20131003042255.GN7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:15PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Change the multiplatform kconfig bits for KZM9D from
> CONFIG_MACH_KZM9D_REFERENCE into CONFIG_MACH_KZM9D
> to match the non-multiplatform case.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/Kconfig  |   10 ++--------
>  arch/arm/mach-shmobile/Makefile |    4 ++++
>  2 files changed, 6 insertions(+), 8 deletions(-)

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
