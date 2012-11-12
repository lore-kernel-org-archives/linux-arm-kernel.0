From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 15:03:28 +0000
Subject: [PATCH 01/14] pinctrl: SPEAr: add spi chipselect control driver
In-Reply-To: <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <4a92290e8a3b1a19c3a5e864edfa7badfc2af5d0.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <201211121503.28392.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 November 2012, Viresh Kumar wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> SPEAr platform provides a provision to control chipselects of ARM PL022
> Prime Cell spi controller through its system registers, which otherwise
> remains under PL022 control which some protocols do not want.
> 
> This commit intends to provide the spi chipselect control in software
> over gpiolib interface. Since it is tied to pinctrl, we place it under
> 'drivers/pinctrl/spear/' directory.
> 
> spi chip drivers can use the exported gpiolib interface to define their
> chipselect through DT or platform data.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>

The driver looks ok to me, but I'll wait for Linus to take a look first
and give his ack.

	Arnd
