From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 10 Aug 2010 14:44:24 -0700
Subject: [GIT PULL] Initial Tegra ARM support
In-Reply-To: <AANLkTi=dcQrik=+5xfwbNo_w7WkTOKZiKAFYFhwzbS=_@mail.gmail.com>
References: <AANLkTi=dcQrik=+5xfwbNo_w7WkTOKZiKAFYFhwzbS=_@mail.gmail.com>
Message-ID: <1281476664.9400.36.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-08-05 at 14:10 -0700, Erik Gilling wrote:
> Hi Linus,
> 
> The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51:
>   Linus Torvalds (1):
>         Linux 2.6.35
> 
> are available in the git repository at:
> 
>   git://android.kernel.org/kernel/tegra.git for-linus
> 
> This code has received review on linux-arm-kernel and has been in
> for-next since June 18th.  No subsystems were harmed out side of
> mach-tegra.
> 
> Colin Cross (4):
>       [ARM] tegra: Add clock support
>       [ARM] tegra: SMP support


This fixes some typos in the Tegra tree which caused build failures in
all ARM compiles.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0ca4a94..a5d4dae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1188,8 +1188,8 @@ config LOCAL_TIMERS
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
-		ARCH_U8500 || ARCH_TEGRA
+	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \
+		ARCH_U8500 || ARCH_TEGRA)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
-- 
1.7.0.4




-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
