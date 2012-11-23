From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 Nov 2012 20:14:27 +0800
Subject: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
 detection on Dove
In-Reply-To: <20121123085726.GK5764@n2100.arm.linux.org.uk>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
 <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
 <20121123083117.GA25754@S2100-06.ap.freescale.net>
 <20121123085726.GK5764@n2100.arm.linux.org.uk>
Message-ID: <20121123121422.GA26168@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 08:57:26AM +0000, Russell King - ARM Linux wrote:
> Does this work with the sdhci stuff?

Honestly, I'm not sure, but I guess it does, since I have seen
sdhci-pxav3 driver using the helpers.  Anyway, I'm going to adopt
the helpers for sdhci-esdhc-imx driver to find it out.

Shawn
