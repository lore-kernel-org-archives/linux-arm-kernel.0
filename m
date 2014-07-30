From: olof@lixom.net (Olof Johansson)
Date: Wed, 30 Jul 2014 12:52:42 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable TI PIPE3 PHY driver
In-Reply-To: <1406625328-26112-1-git-send-email-rogerq@ti.com>
References: <1406540737-9493-1-git-send-email-rogerq@ti.com>
 <1406625328-26112-1-git-send-email-rogerq@ti.com>
Message-ID: <20140730195242.GF18384@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 12:15:28PM +0300, Roger Quadros wrote:
> This driver is needed by SATA, PCIe and USB modules on TI SoCs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

What's this based on? It doesn't apply on top of next/defconfig. Please
base it on there and resend. (or linux-next or our for-next branch, which
should be all the same).

Thanks,

-Olof
