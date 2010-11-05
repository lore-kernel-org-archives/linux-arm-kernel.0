From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Nov 2010 13:06:30 +0100
Subject: [PATCH 1/3] ARM mx3_camera: check for DMA engine type
In-Reply-To: <Pine.LNX.4.64.1011051136000.28289@axis700.grange>
References: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
	<1288949165-13286-2-git-send-email-s.hauer@pengutronix.de>
	<Pine.LNX.4.64.1011051136000.28289@axis700.grange>
Message-ID: <20101105120630.GU6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 05, 2010 at 11:37:10AM +0100, Guennadi Liakhovetski wrote:
> On Fri, 5 Nov 2010, Sascha Hauer wrote:
> 
> > We have two dma engines in MX3 systems: The IPU and the SDMA
> > engine. We have to check if we got a channel from the correct
> > engine before proceeding with a channel.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Thanks, since this is a fix and the SDMA is already in the mainline, I can 
> pull this via v4l for 37-rc2.

Ok, I'll remove it from my queue then.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
