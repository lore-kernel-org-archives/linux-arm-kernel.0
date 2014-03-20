From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Mar 2014 17:15:14 +0800
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1395235406-13449-1-git-send-email-y>
References: <1395235406-13449-1-git-send-email-y>
Message-ID: <532AB1A2.9010702@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?19? 21:23, y at karo-electronics.de ??:
> configurable via DT. This is required for the Ka-Ro electronics
> platforms.
>
If you disable the swapping, you will disable the NAND boot in actually.

do you need the nand boot?

could you please tell me more detail background?

thanks
Huang Shijie
