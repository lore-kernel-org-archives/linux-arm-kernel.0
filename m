From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jan 2017 09:31:24 -0800
Subject: [PATCH] ARM: dts: am335x-icev2: Remove the duplicated pinmux
 setting
In-Reply-To: <20170104050940.25698-1-lokeshvutla@ti.com>
References: <20170104050940.25698-1-lokeshvutla@ti.com>
Message-ID: <20170105173123.GM4310@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [170103 21:12]:
> There is no mmc sd card detect on am335x-ice board. But the spi0_cs1
> pin being configured as mmcsd_cd. Removing it fixes the below warning
> during boot.

Applying into omap-for-v4.11/fixes thanks.

Tony
