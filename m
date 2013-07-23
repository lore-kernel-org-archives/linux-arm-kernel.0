From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Jul 2013 10:24:55 +0900
Subject: [PATCH 04/04] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer
 configuration
In-Reply-To: <20130717203127.27542.41663.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
 <20130717203127.27542.41663.sendpatchset@w520>
Message-ID: <20130723012454.GE16481@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 05:31:27AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Move the timer configuration bits to allow use in
> case of ARCH_SHMOBILE or ARCH_SHMOBILE_MULTI.
> 
> The timers all make use of the regular driver model
> so they are safe to enable for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/Kconfig |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Thanks, I have queued this up for v3.12 in a new multiarch branch
of the renesas tree.
