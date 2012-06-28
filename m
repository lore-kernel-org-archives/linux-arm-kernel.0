From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 13:30:40 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20459.59910.783086.760997@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20459.59910.783086.760997@ipc1.ka-ro>
Message-ID: <20120628053038.GC30041@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 07:22:14AM +0200, Lothar Wa?mann wrote:
> > +- phy-enable-gpios : Specify the gpio used to enable phy
> > +- phy-standby-gpios : Specify the gpio used to put phy into STANDBY mode
> >  
> Why the plural form 'gpios'? It's just one gpio.
> s/gpios/gpio/ ?
> 
It's a common pattern suggested by common gpio bindings
Documentation/devicetree/bindings/gpio/gpio.txt.

-- 
Regards,
Shawn
