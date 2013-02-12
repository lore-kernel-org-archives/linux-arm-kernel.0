From: avinashphilip@ti.com (Philip, Avinash)
Date: Tue, 12 Feb 2013 06:55:18 +0000
Subject: [PATCH 4/7] ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
In-Reply-To: <alpine.DEB.2.00.1302081505350.28008@utopia.booyaka.com>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
 <1357133094-30806-5-git-send-email-avinashphilip@ti.com>
 <alpine.DEB.2.00.1302081505350.28008@utopia.booyaka.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA73534@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 08, 2013 at 20:36:53, Paul Walmsley wrote:
> Hi,
> 
> On Wed, 2 Jan 2013, Philip Avinash wrote:
> 
> > EHRPWM module requires explicit clock gating of TBCLK from control
> > module. Hence add TBCLK clock node in clock tree for EHRPWM modules.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> 
> This patch adds some sparse[1] warnings:
> 
> > arch/arm/mach-omap2/cclock33xx_data.c:844:1: warning: Using plain 
> integer as NULL pointer
> > arch/arm/mach-omap2/cclock33xx_data.c:850:1: warning: Using plain 
> integer as NULL pointer
> > arch/arm/mach-omap2/cclock33xx_data.c:856:1: warning: Using plain 
> integer as NULL pointer
> 
> Could you fix these, please?

Sorry for late response. I will send an updated version with fix for
sparse warnings.

Thanks
Avinash

> 
> 
> - Paul
> 
> 1. Sparse: https://sparse.wiki.kernel.org/index.php/Main_Page
> 
> 
