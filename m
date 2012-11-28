From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Nov 2012 08:22:59 +0100
Subject: [PATCH v2] ARM: dts: mx27: Fix the AIPI bus for FEC
In-Reply-To: <CAOMZO5BZnpNrS_kKiqTmzYtzW7jQOtmHN-3cGH-10rj2v66Jjw@mail.gmail.com>
References: <1353525578-20309-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5BZnpNrS_kKiqTmzYtzW7jQOtmHN-3cGH-10rj2v66Jjw@mail.gmail.com>
Message-ID: <20121128072259.GM10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 02:28:41PM -0200, Fabio Estevam wrote:
> Hi Sascha,
> 
> On Wed, Nov 21, 2012 at 5:19 PM, Fabio Estevam
> <fabio.estevam@freescale.com> wrote:
> > FEC controller is connected to AIPI2 bus.
> >
> > Also fix the AIPI1 address range.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Changes since v1:
> > - Remove ethernet from aipi1 bus on phytec board.
> 
> This one is a bug fix. Could this be applied?

Just did that.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
