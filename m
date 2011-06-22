From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 Jun 2011 09:09:47 +0200
Subject: [PATCHv7] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <874o3i9x89.fsf@lebrac.rtp-net.org>
References: <1301325297-24126-1-git-send-email-Dinh.Nguyen@freescale.com>
	<87k4cfa550.fsf@lebrac.rtp-net.org>
	<20110621223527.GF6069@pengutronix.de>
	<874o3i9x89.fsf@lebrac.rtp-net.org>
Message-ID: <20110622070947.GH6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 08:49:42AM +0200, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> Hi,
> 
> > On Tue, Jun 21, 2011 at 11:46:35AM +0200, Arnaud Patard wrote:
> >> <Dinh.Nguyen@freescale.com> writes:
> >> 
> >> Hi,
> >> 
> >> > From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> >> >
> >> > Adds initial low power suspend functionality to MX51.
> >> > Supports "mem" and "standby" modes.
> >> >
> >> > Tested on mx51-babbage.
> >> >
> >> > Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> >> 
> >> I fail to see this patch in imx tree. Did it get merged in some other
> >> tree ?
> >
> > Not yet. Have you tested this patch?
> >
> Yes, it works fine on my platforms.

I took this as a tested-by and applied the patch.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
