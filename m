From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Thu, 6 Sep 2012 20:30:35 +0530
Subject: [PATCH] arm: omap: hwmod: make *phy_48m* as the main_clk of
 ocp2scp
In-Reply-To: <1341219337-25815-1-git-send-email-kishon@ti.com>
References: <1341219337-25815-1-git-send-email-kishon@ti.com>
Message-ID: <CAAe_U6Kn6DxV45OqOMU3yqpk1OMbWS2621AWvJJQE0SW4vMcLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 2, 2012 at 2:25 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Made *ocp2scp_usb_phy_phy_48m* as the main_clk for ocp2scp.
> Since this ocp2scp module does not have any fck but does have a
> single opt_clock, it is added as the main_clk for ocp2scp. Also
> removed phy_48m as the optional clock since it is now made as the
> main clock.
>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

If there is not any comments for this patch, can someone queue it.
This is needed for musb to be functional with dt in omap4.

Thanks
Kishon
