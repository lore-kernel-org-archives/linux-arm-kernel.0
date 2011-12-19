From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 Dec 2011 15:13:51 +0800
Subject: [PATCH v3] ARM: mxs: Add initial support for Bluegiga APX4
 Development Kit
In-Reply-To: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1323766966-30502-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <20111219071350.GH4962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 11:02:46AM +0200, Lauri Hintsala wrote:
> Added initial support for APX4 Development Kit with RTC, LED, Ethernet,
> Audio, SDIO, I2C, DUART and AUART support.
> 
> cc: shawn.guo at linaro.org
> Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> Signed-off-by: Veli-Pekka Peltola <veli-pekka.peltola@bluegiga.com>

The patch looks good.  The only problem I have is I do not see
MACH_TYPE_APX4DEVKIT defined in arch/arm/tools/mach-types on either
Linus' tree or linux-next tree.  I'm afraid that we will experience
the same problem we have experienced with m28evk patch, which broke
the whole mxs build for a couple of early -rc of v3.2.

-- 
Regards,
Shawn
