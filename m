From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Jun 2013 23:09:37 +0900
Subject: [PATCH 01/06] ARM: shmobile: Add SMP boot function and argument
In-Reply-To: <20130610091936.18944.66463.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
 <20130610091936.18944.66463.sendpatchset@w520>
Message-ID: <20130612140936.GR32751@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 06:19:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add code for mach-shmobile to allow specifying boot function
> and argument. Will initially be used for SMP together with SCU
> but may in the future also be used for deep sleep resume. This
> patch removes one inline virtual to physical address conversion.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/headsmp.S             |   13 ++++++++++---
>  arch/arm/mach-shmobile/include/mach/common.h |    4 +++-
>  2 files changed, 13 insertions(+), 4 deletions(-)

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
