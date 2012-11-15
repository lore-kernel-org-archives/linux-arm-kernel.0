From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Nov 2012 14:44:32 +0100
Subject: [PATCH v2 1/2] ARM: mx27: Add VPU support
In-Reply-To: <CAOMZO5BrzD5okmRMcY3X3aquMpmxV5Pn2k2upsQNhsmq_Pi5-A@mail.gmail.com>
References: <1352917238-29694-1-git-send-email-fabio.estevam@freescale.com>
 <20121115081223.GY10369@pengutronix.de>
 <CAOMZO5BrzD5okmRMcY3X3aquMpmxV5Pn2k2upsQNhsmq_Pi5-A@mail.gmail.com>
Message-ID: <20121115134432.GG10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 11:38:01AM -0200, Fabio Estevam wrote:
> On Thu, Nov 15, 2012 at 6:12 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > As Eric mentioned this may lead to problems on the i.MX27L without VPU.
> > Do you have the possibility to test this?
> 
> I do not have any board with a MX27L variant. Maybe we could try
> reading the SREV info register to distinguish between MX27 and MX27L.
> MX27RM does not provide any info on this though.

If that works I would prefer this, but I also have no i.MX27L to test
it. Otherwise doing it like v1 is the best we can do.
You should probably put the changes to Javiers board into a separate
patch so that Javier can Ack it indepently of what we are coming up
with.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
