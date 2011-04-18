From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 18 Apr 2011 10:20:49 +0200
Subject: [PATCH] V4L: mx3_camera: select VIDEOBUF2_DMA_CONTIG instead
	of VIDEOBUF_DMA_CONTIG
In-Reply-To: <Pine.LNX.4.64.1104181013250.27247@axis700.grange>
References: <1302166243-650-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110418080637.GA31131@pengutronix.de>
	<Pine.LNX.4.64.1104181013250.27247@axis700.grange>
Message-ID: <20110418082049.GJ3811@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Mon, Apr 18, 2011 at 10:14:56AM +0200, Guennadi Liakhovetski wrote:
> It's been pushed upstream almost 2 weeks ago:
>
> http://article.gmane.org/gmane.linux.drivers.video-input-infrastructure/31352

As our autobuilder does still trigger, I assume that the configs have to
be refreshed and it may be an issue on our side. Can you take care of
that?

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
