From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2016 00:26:38 +0200
Subject: [PATCH] ARM: u8500_defconfig: turn on the Synaptics RMI4 driver
In-Reply-To: <1458550237-11607-1-git-send-email-linus.walleij@linaro.org>
References: <1458550237-11607-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4997479.iKb4xpQBLQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 March 2016 09:50:37 Linus Walleij wrote:
> The Ux500 boards may have an RMI4 unit, and the DT fragments for
> them have been merged upstream. Add it to the defconfig.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for v4.6 so our defconfig
> is in sync with available upstream drivers.
> 

Applied to fixes, thanks

	Arnd
