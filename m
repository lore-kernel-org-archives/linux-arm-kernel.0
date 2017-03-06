From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Mar 2017 10:42:16 -0800
Subject: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data
 to device tree
In-Reply-To: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20170306184215.GO20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [170301 02:31]:
> Currently the slope and offset values for calculating the
> hot spot temperature of a particular thermal zone is part
> of driver data. Pass them here instead and obtain the values
> while of node parsing.
> 
> Tested for the slope and constant values on DRA7-EVM.
> 
> Keerthy (7):
>   ARM: DRA7: Thermal: Add slope and offset values
>   ARM: OMAP5: Thermal: Add slope and offset values
>   ARM: OMAP443x: Thermal: Add slope and offset values
>   ARM: OMAP4460: Thermal: Add slope and offset values
>   thermal: ti-soc-thermal: Fetch slope and offset from DT
>   thermal: ti-soc-thermal: Remove redundant constants
>   thermal: ti-soc-thermal: Remove redundant code

Are the dts changes safe for me to pick separately into
omap-for-v4.12/dt?

Regards,

Tony
