From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 19:30:49 +0800
Subject: [PATCH V2] MXS: Add DT binding support into stmp3xxx-rtc
In-Reply-To: <4FED8CA1.5000800@pengutronix.de>
References: <1339181804-22822-1-git-send-email-marex@denx.de>
 <20120625043711.GA18156@S2101-09.ap.freescale.net>
 <4FED8CA1.5000800@pengutronix.de>
Message-ID: <20120629113047.GD29197@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 01:08:17PM +0200, Marc Kleine-Budde wrote:
> On 06/25/2012 06:37 AM, Shawn Guo wrote:
> > On Fri, Jun 08, 2012 at 08:56:44PM +0200, Marek Vasut wrote:
> >> Add simple binding for the stmp3xxx-rtc.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Alessandro Zummo <a.zummo@towertech.it>
> > 
> > Hi Alessandro,
> > 
> > The patch has some changes on arch/arm/boot/dts/imx28.dtsi, and also we
> > need the patch to convert some board files over to device tree.  May I
> > have your ack to queue the patch on my tree?
> 
> The interrupt numbers are not as the driver expects them..
> 
Right.  I sent a v3 fixing it.

http://article.gmane.org/gmane.linux.drivers.devicetree/17133

-- 
Regards,
Shawn
