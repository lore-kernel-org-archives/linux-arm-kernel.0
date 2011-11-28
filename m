From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Nov 2011 10:32:09 +0100
Subject: [PATCH] dma i.MX: remove individual SOC dependency
In-Reply-To: <1322451777.1516.979.camel@vkoul-udesk3>
References: <1321958598-27260-1-git-send-email-s.hauer@pengutronix.de>
 <1322451777.1516.979.camel@vkoul-udesk3>
Message-ID: <20111128093209.GT27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, Nov 28, 2011 at 09:12:57AM +0530, Vinod Koul wrote:
> On Tue, 2011-11-22 at 11:43 +0100, Sascha Hauer wrote:
> > The individual SoC dependency in Kconfig hardly scales anymore.
> > Instead of having such a fine grained dependency just depend
> > on ARCH_MXC and risk that the uninformed user has to look in
> > the help text to figure out which driver is the correct one.
> Not sure why it was resent but this already in my tree

I thought you missed it. If you already have it everything is fine.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
