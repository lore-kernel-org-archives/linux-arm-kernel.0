From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Feb 2013 15:06:53 +0000 (UTC)
Subject: [PATCH 4/7] ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
In-Reply-To: <1357133094-30806-5-git-send-email-avinashphilip@ti.com>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
 <1357133094-30806-5-git-send-email-avinashphilip@ti.com>
Message-ID: <alpine.DEB.2.00.1302081505350.28008@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2 Jan 2013, Philip Avinash wrote:

> EHRPWM module requires explicit clock gating of TBCLK from control
> module. Hence add TBCLK clock node in clock tree for EHRPWM modules.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

This patch adds some sparse[1] warnings:

> arch/arm/mach-omap2/cclock33xx_data.c:844:1: warning: Using plain 
integer as NULL pointer
> arch/arm/mach-omap2/cclock33xx_data.c:850:1: warning: Using plain 
integer as NULL pointer
> arch/arm/mach-omap2/cclock33xx_data.c:856:1: warning: Using plain 
integer as NULL pointer

Could you fix these, please?


- Paul

1. Sparse: https://sparse.wiki.kernel.org/index.php/Main_Page
