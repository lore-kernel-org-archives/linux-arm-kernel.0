From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 May 2012 22:43:17 +0800
Subject: [PATCH 08/10] mmc: mxs-mmc: add device tree support
In-Reply-To: <201205080158.07259.marex@denx.de>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
 <1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
 <201205080158.07259.marex@denx.de>
Message-ID: <20120508144315.GH2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 08, 2012 at 01:58:07AM +0200, Marek Vasut wrote:
> > +Optional properties:
> > +- wp-gpios: Specify GPIOs for write protection
> 
> You can have multiple wp-gpio per port? :-)
> 
This is a naming idiom documented in
Documentation/devicetree/bindings/gpio/gpio.txt

-- 
Regards,
Shawn
