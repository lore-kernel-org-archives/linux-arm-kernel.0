From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Jun 2017 00:32:07 -0700
Subject: [PATCH v2] ARM: dts: AM43XX: Remove min and max voltage values
 for dcdc3
In-Reply-To: <1496395441-29526-1-git-send-email-j-keerthy@ti.com>
References: <1496395441-29526-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20170606073207.GV3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [170602 02:27]:
> dcdc3 supplies to DDR on AM43x series. When we set both
> min and max values to the same value. The regulator framework
> sets that particular voltage. This is bad as we are changing
> the ddr voltage when executing from ddr. Hence remove the min and
> max values. The ddr supply voltage shall be set from bootloader
> when not executing from ddr and not while executing from kernel.
> 
> The previous discussion can be found here:
> 
> http://www.spinics.net/lists/devicetree/msg56399.html
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applying into omap-for-v4.13/dt thanks.

Tony
