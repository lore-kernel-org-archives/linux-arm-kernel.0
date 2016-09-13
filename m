From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Sep 2016 17:43:19 +0200
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.9
In-Reply-To: <1473670948-4265-3-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
 <1473670948-4265-3-git-send-email-shawnguo@kernel.org>
Message-ID: <48242366.xxuzqMPmUj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 5:02:26 PM CEST Shawn Guo wrote:
> i.MX device tree changes for 4.9:
>  - Add SoC support for i.MX7 Solo which is a reduced version of i.MX7
>    Dual.
>  - New board support: Gateworks Ventana i.MX6Q/DL GW553x, Inverse Path
>    i.MX53 USB armory, i.MX6Q/DL TS-4900 from Technologic Systems,
>    i.MX6UL GEA M6UL modules from Engicam, i.MX7 Solo Warp7 board.
>  - Add DMA and IPU CSI devices for i.MX53 SoC support.
>  - Refine i.MX7 Dual SoC DTS as a preparation of i.MX7 Solo support.
>  - Use of_graph dt nodes to describe the panel for vf610-colibri and
>    ls1021a-twr boards.
>  - Add gpio-ranges property to i.MX6 GPIO controllers, which will be
>    useful when GPIO driver is changed to request pad configuration as
>    GPIO function.
>  - Random device additions or small changes for various board support.
> 
> 

Pulled into next/dt, thanks!

	Arnd
