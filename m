From: johnstul@us.ibm.com (John Stultz)
Date: Tue, 13 Nov 2012 10:58:54 -0800
Subject: [PATCH V4 3/3] clocksource: time-armada-370-xp converted to clk
 framework
In-Reply-To: <1351621413-3637-4-git-send-email-gregory.clement@free-electrons.com>
References: <1351621413-3637-1-git-send-email-gregory.clement@free-electrons.com>
 <1351621413-3637-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <50A2986E.9020202@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 11:23 AM, Gregory CLEMENT wrote:
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> cc: John Stultz <johnstul@us.ibm.com>
> ---
>   arch/arm/boot/dts/armada-370-db.dts      |    4 ----
>   arch/arm/boot/dts/armada-370-xp.dtsi     |    1 +
>   drivers/clocksource/time-armada-370-xp.c |   11 ++++++-----
>   3 files changed, 7 insertions(+), 9 deletions(-)

This is missing the patch description.  Since none of it is 
code/hardware I'm familiar with, I can't really closely review whats 
being done. So its much more critical that the patch have a clear 
description of what its doing.

thanks
-john
