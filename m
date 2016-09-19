From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 16:55:34 +0200
Subject: [GIT PULL 2/5] i.MX soc updates for 4.9
In-Reply-To: <1473670948-4265-2-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <1473670948-4265-2-git-send-email-shawnguo@kernel.org>
Message-ID: <2416459.S08fG0c66O@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 5:02:25 PM CEST Shawn Guo wrote:
> i.MX SoC updates for 4.9:
>  - Set INT_MEM_CLK_LPM bit to get proper WAIT mode support on i.MX6SX.
>    This is a workaround for i.MX6SX WAIT mode hardware issue.
>  - Enable cpuidle support with 3 low-power states (WFI, WAIT, POWER-OFF)
>    for i.MX6UL.
> 
> 

Pulled into next/soc, thanks!

	Arnd
