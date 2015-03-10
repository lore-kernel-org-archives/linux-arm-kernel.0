From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 10 Mar 2015 10:57:13 +0100
Subject: [PATCH v2 03/10] reset: berlin: convert to a platform driver
In-Reply-To: <1425896186.3152.25.camel@pengutronix.de>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-4-git-send-email-antoine.tenart@free-electrons.com>
 <1425896186.3152.25.camel@pengutronix.de>
Message-ID: <20150310095713.GD23469@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Mar 09, 2015 at 11:16:26AM +0100, Philipp Zabel wrote:
> 
> Am Freitag, den 06.03.2015, 16:05 +0100 schrieb Antoine Tenart:
> > The Berlin reset controller was introduced without being a platform
> > driver because of a needed DT rework: the node describing the reset
> > controller also describes the pinctrl and clk controllers...
> > 
> > The DT issue being solved thanks to the addition of the Berlin
> > controller mfd driver, it is now possible to convert the Berlin reset
> > driver to a plaftorm driver.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> Looks good to me. Do you want to merge this together with the rest of
> the series, or should I queue the reset patch?

I think we better wait for the simple-mfd patch to make it to ARM SoC
first.

Once this is done, you can queue the reset patch (unless Sebastian wants
to take it alongside the series).

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
