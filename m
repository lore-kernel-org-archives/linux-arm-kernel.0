From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 4 Nov 2010 19:30:47 +0100
Subject: [PATCH 1/3] ARM mx3fb: check for DMA engine type
In-Reply-To: <Pine.LNX.4.64.1011041829040.13123@axis700.grange>
References: <1288888459-7293-1-git-send-email-s.hauer@pengutronix.de>
	<1288888459-7293-2-git-send-email-s.hauer@pengutronix.de>
	<Pine.LNX.4.64.1011041829040.13123@axis700.grange>
Message-ID: <20101104183047.GP6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Thu, Nov 04, 2010 at 06:30:14PM +0100, Guennadi Liakhovetski wrote:
> On Thu, 4 Nov 2010, Sascha Hauer wrote:
> 
> > We have two dma engines in MX3 systems: The IPU and the SDMA
> > engine. We have to check if we got a channel from the correct
> > engine before proceeding with a channel.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Yeah, looks right:
> 
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Could you also make a similar one for drivers/media/video/mx3_camera.c?

Yes, will do. I missed that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
