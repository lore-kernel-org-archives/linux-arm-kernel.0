From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Jul 2014 15:24:26 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: major refresh
In-Reply-To: <1406052070-6207-1-git-send-email-olof@lixom.net>
References: <1406052070-6207-1-git-send-email-olof@lixom.net>
Message-ID: <1406125466.25343.138.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 19:01 +0100, Olof Johansson wrote:
> This is a major refresh of the multi_v7_defconfig:
> 
> - Bring over a bunch of Samsung drivers to make ODROID-U3 and Chromebooks usable
>  * Enable big.LITTLE
>  * MCPM
>  * CYAPA touchpad
>  * Samsung-related MTD/regulator/clk/pinmux drivers
>  * Add some of the CrOS EC drivers
> - Turn on TPM, HW_RANDOM
> - OMAP_USB3 -> TI_PIPE3 option rename
> - Enable MCPM/b.L for VEXPRESS
> - Add new CONFIG_MTD_SPI_NOR since it otherwise masks off SPI NOR drivers
> - CONFIG_LOGO, because penguins.
> 
> I took care to keep the new options that have been added for whose the
> drivers are not yet in our for-next branch. This was pretty awkward so
> we should sort out how to handle those better in the future.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

It doesn't apply cleanly on 3.16-rc6, but after manual merge VE still
boots :-) (for what it's worth)

Pawe?
