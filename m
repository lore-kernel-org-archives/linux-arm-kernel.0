From: marex@denx.de (Marek Vasut)
Date: Sat, 9 Jun 2012 13:11:42 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120609105330.GF30400@pengutronix.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de>
 <201206091234.47309.marex@denx.de> <20120609105330.GF30400@pengutronix.de>
Message-ID: <201206091311.43229.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Sat, Jun 09, 2012 at 12:34:47PM +0200, Marek Vasut wrote:
> > Dear Shubhrajyoti Datta,
> > 
> > > Didnt understand this.
> > 
> > What exactly, it's running (according to the datasheet) at 95kHz.
> > 
> > > > +       .timing0        = 0x00780030,
> > > > +       .timing1        = 0x00800030,
> > > > +       .timing2        = 0x0015000d,
> > > > +};
> > > > +
> > > > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> > > > +       .timing0        = 0x000f0007,
> > > > +       .timing1        = 0x001f000f,
> > > > +       .timing2        = 0x0015000d,
> > > > +};
> > > > +
> > > 
> > > How are these values calculated?
> > 
> > They're not calculated, they're presented in the datasheet. There's no
> > formula, even though I believe one could be derived given enough effort.
> 
> Don't these values depend on the input clock of this unit? I don't know,
> just asking.

Isn't the i2c block supplied from 24MHz clock source in the mx28?

> Sascha

Best regards,
Marek Vasut
