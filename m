From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Aug 2015 17:53:21 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup changes for v4.3
In-Reply-To: <55D748E0.3080004@free-electrons.com>
References: <55D748E0.3080004@free-electrons.com>
Message-ID: <55D74971.2090404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/2015 17:50, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v4.2.

Obviously the title is wrong! it is really a fix for 4.2 and not a
cleanup for 4.3

> I hope it is not too late, if it can't make ti for 4.2, then we
> will apply it on 4.3, anyway the bug is here since 3.18.
> 
> Gregory
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.2-1
> 
> for you to fetch changes up to 5be9fc23cdb42e1d383ecc8eae8a8ff70a752708:
> 
>   ARM: orion5x: fix legacy orion5x IRQ numbers (2015-08-21 17:33:08 +0200)
> 
> ----------------------------------------------------------------
> mvebu fixes changes for v4.2
> 
> Fix legacy orion5x IRQ numbers broken since 3.18
> 
> ----------------------------------------------------------------
> Benjamin Cama (1):
>       ARM: orion5x: fix legacy orion5x IRQ numbers
> 
>  arch/arm/Kconfig                          |  1 +
>  arch/arm/mach-orion5x/include/mach/irqs.h | 64 +++++++++++++++----------------
>  arch/arm/mach-orion5x/irq.c               |  4 +-
>  3 files changed, 35 insertions(+), 34 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
