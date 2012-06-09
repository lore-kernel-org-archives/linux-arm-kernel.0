From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 9 Jun 2012 12:53:30 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201206091234.47309.marex@denx.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
 <CAM=Q2cuv0NQTYJH=+d6Na+JK5rGYsLiSmuX7g8T-_Ry7bs3fRQ@mail.gmail.com>
 <201206091234.47309.marex@denx.de>
Message-ID: <20120609105330.GF30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 09, 2012 at 12:34:47PM +0200, Marek Vasut wrote:
> Dear Shubhrajyoti Datta,
> 
> 
> > Didnt understand this.
> 
> What exactly, it's running (according to the datasheet) at 95kHz.
> 
> > > +       .timing0        = 0x00780030,
> > > +       .timing1        = 0x00800030,
> > > +       .timing2        = 0x0015000d,
> > > +};
> > > +
> > > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> > > +       .timing0        = 0x000f0007,
> > > +       .timing1        = 0x001f000f,
> > > +       .timing2        = 0x0015000d,
> > > +};
> > > +
> > 
> > How are these values calculated?
> 
> They're not calculated, they're presented in the datasheet. There's no formula, 
> even though I believe one could be derived given enough effort.

Don't these values depend on the input clock of this unit? I don't know,
just asking.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
