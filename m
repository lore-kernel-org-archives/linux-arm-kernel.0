From: horms@verge.net.au (Simon Horman)
Date: Mon, 13 May 2013 10:33:22 +0900
Subject: [PATCH] ARM: shmobile: r8a7778: correct model name in Kconfig
In-Reply-To: <87obcfn350.wl%kuninori.morimoto.gx@renesas.com>
References: <201305090405.41053.sergei.shtylyov@cogentembedded.com>
 <20130510082055.GB27435@verge.net.au>
 <518D4CCF.5040706@cogentembedded.com>
 <87obcfn350.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130513013320.GD7826@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 12, 2013 at 05:18:41PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > >> The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
> > >> M1S which is a SH based SoC.
> > >>
> > >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > Morimoto-san,
> > >
> > > please review this change.
> > >
> > 
> >     This patch was based on the info found on this official Renesas webpage:
> > 
> > http://www.renesas.eu/applications/automotive/cis/cis_highend/rcar_m1as/index.jsp
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 

Thanks, I have queued-up the following in the soc-r8a7778 branch.
There was a trivial conflict which I resolved. Please let me know
if I messed it up.

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

ARM: shmobile: r8a7778: correct model name in Kconfig

The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
M1S which is a SH based SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas at verge.net.au: manually applied to soc-r8a7778 branch]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3e7ad45..3c463ff 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,7 @@ config ARCH_R8A7740
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
-	bool "R-Car M1 (R8A77780)"
+	bool "R-Car M1A (R8A77781)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select CPU_V7
 	select SH_CLK_CPG
-- 
1.8.2.1
