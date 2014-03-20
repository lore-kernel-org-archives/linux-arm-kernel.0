From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 19:22:31 +0100
Subject: [PATCH 06/62] ARM: davinci: export da8xx_syscfg0_base
In-Reply-To: <532B3A91.6000800@cogentembedded.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403201250.45005.arnd@arndb.de> <532B3A91.6000800@cogentembedded.com>
Message-ID: <5091055.xba9009NTn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 21:59:29 Sergei Shtylyov wrote:
> 
>     Yes, it does. The issue is that the PHY code is different in MUSB and OHCI 
> drivers. I don't think the PHY driver knows what device binds to it.

At least in the DT case, it can get that information from DT, when you
set #phy-cells=<1>. I don't know how it would be done for platform_data,
but I assume one could find a way too.

	Arnd
