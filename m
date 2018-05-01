From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 May 2018 08:20:43 -0700
Subject: [PATCH] ARM: dts: omap3-gta04: Add fixed 26MHz clock as fck for
 twl
In-Reply-To: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
References: <c0b35797744a71df9d8088508814675cc5f07710.1522944315.git.hns@goldelico.com>
Message-ID: <20180501152042.GA98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [180405 09:07]:
> The board uses 26MHz oscillator for the twl4030 HFCLK.
> This way we will not depend on the bootloader to configure the
> CFG_BOOT:HFCLK_FREQ
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into omap-for-v4.18/dt thanks.

Tony
