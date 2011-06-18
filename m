From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Jun 2011 20:11:32 +0200
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <20110618162655.GK8195@ponder.secretlab.ca>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<201106181821.46574.arnd@arndb.de>
	<20110618162655.GK8195@ponder.secretlab.ca>
Message-ID: <201106182011.33146.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 June 2011 18:26:55 Grant Likely wrote:
> On Sat, Jun 18, 2011 at 06:21:46PM +0200, Arnd Bergmann wrote:

> > Should this also support the "clock-frequency" property that 8250-style
> > serial ports support [1]?
> > 
> > For the flow-control properties, should we name that more generic? The
> > same property certainly makes sense for other serial-ports if it does
> > here. OTOH, I'm not sure it's actually reliable, because it also depends
> > on whether the other side of the connection and the cable support hw flow
> > control.
> 
> I'd like to see a few use cases before defining a common property.
> That said, has-rts-cts does sound like a useful generic property.
> Or maybe named "uart-has-rts-cts" to make it clear that it is a uart
> specific binding?
> 


Sounds ok to me.

	Arnd
