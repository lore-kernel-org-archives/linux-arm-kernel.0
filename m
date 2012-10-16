From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Oct 2012 09:13:57 +0200
Subject: [PATCH 1/2] ARM: mx27_3ds: Reserve memory for camera usage
In-Reply-To: <CAOMZO5DqJuernaHk-4KO_v=8vPCnrpqCZ-uZ2nrhtFcKo9xObA@mail.gmail.com>
References: <1349839770-13848-1-git-send-email-festevam@gmail.com>
 <20121010075222.GN27665@pengutronix.de>
 <CAOMZO5DqJuernaHk-4KO_v=8vPCnrpqCZ-uZ2nrhtFcKo9xObA@mail.gmail.com>
Message-ID: <20121016071357.GT27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 01:08:57AM -0300, Fabio Estevam wrote:
> On Wed, Oct 10, 2012 at 4:52 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Wed, Oct 10, 2012 at 12:29:29AM -0300, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Reserve dedicated memory block for camera usage.
> >
> > Why not use CMA?
> 
> Sorry, not familiar with CMA. Could you please point to some board
> file/driver that makes use of it?

You just have to enable it. The driver then can use dma_alloc_* as it
used to.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
