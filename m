From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Nov 2012 13:41:06 +0100
Subject: [PATCH 1/2] ARM: i.MX27: Add platform support for IRAM.
In-Reply-To: <Pine.LNX.4.64.1211061232510.6451@axis700.grange>
References: <1352131185-12079-1-git-send-email-javier.martin@vista-silicon.com>
 <Pine.LNX.4.64.1211061232510.6451@axis700.grange>
Message-ID: <20121106124106.GZ1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 12:37:35PM +0100, Guennadi Liakhovetski wrote:
> Hi Javier
> 
> On Mon, 5 Nov 2012, Javier Martin wrote:
> 
> > Add support for IRAM to i.MX27 non-DT platforms using
> > iram_init() function.
> 
> I'm not sure this belongs in a camera driver. Can IRAM not be used for 
> anything else? I'll check the i.MX27 datasheet when I'm back home after 
> the conference, so far this seems a bit odd.

This patch just adds the sram pool to the system in i.MX27 code, the
patch is not camera specific.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
