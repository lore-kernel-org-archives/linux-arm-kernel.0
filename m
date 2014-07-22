From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 22 Jul 2014 15:41:43 +0530
Subject: [Re-send PATCH 1/1] arm: dra7xx: Add hwmod data for MDIO and CPSW
In-Reply-To: <20140717074948.GF18374@atomide.com>
References: <1404825399-10330-1-git-send-email-mugunthanvnm@ti.com>
 <20140717074948.GF18374@atomide.com>
Message-ID: <53CE38DF.1060305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 July 2014 01:19 PM, Tony Lindgren wrote:
> We seem to have this layout WR_SOFT_RESET and WR_CONTROL in the TRM:
>
> WR_SOFT_RESET
> [0]     SOFT_RESET
>
> WR_CONTROL
> [3:2]   MMR_STDBYMODE   0 = force-idle, 1 = no-standby
> [1:0]   MMR_IDLEMODE    0 = force-idle, 1 = no-idle
>
> And so it seems to match what am33xx also has for am33xx_cpgmac_sysc
> and am33xx TRM for 14.5.9 CONTROL register. So as far as I'm concerned:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
Paul,

Can you pull this patch as Tony acked the patch.

Regards
Mugunthan V N
