From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 May 2018 08:19:29 -0700
Subject: [PATCH] ARM: dts: omap3-pandora: Add fixed 26MHz clock as fck
 for twl
In-Reply-To: <cfb1ac64f31a2b01a506390ecb665a1e66d7ce5d.1522944118.git.hns@goldelico.com>
References: <cfb1ac64f31a2b01a506390ecb665a1e66d7ce5d.1522944118.git.hns@goldelico.com>
Message-ID: <20180501151929.GN5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [180405 09:06]:
> The board uses 26MHz oscillator for the twl4030 HFCLK.
> This way we will not depend on the bootloader to configure the
> CFG_BOOT:HFCLK_FREQ
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applying into omap-for-v4.18/dt thanks.

Tony
