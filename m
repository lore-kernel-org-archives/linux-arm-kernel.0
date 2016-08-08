From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Aug 2016 15:30:08 +0800
Subject: [PATCH] ARM: dts: imx: ventana: Add ext watchdog reset
In-Reply-To: <1467207063-4774-1-git-send-email-tharvey@gateworks.com>
References: <1467207063-4774-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20160808073008.GC4678@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 06:31:03AM -0700, Tim Harvey wrote:
> bc677ff42e81bbf78308a7b66cf7b63b0f5c26b0 adds a device-tree property
> to specify that an external watchdog reset is used to reset other
> portions of the board and not just the IMX6 SoC.
> 
> This adds the property to the proper watchdog as well as the pinmux for
> the Gateworks Ventana boards that use this external watchdog reset to
> reset the PMIC which will reset all the PMIC power rails and not just
> a chip-level IMX6 reset. This helps to work around various system issues
> that can cause a hang when coming out of reset.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
