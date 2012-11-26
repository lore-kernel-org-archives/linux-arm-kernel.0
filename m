From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Date: Mon, 26 Nov 2012 08:52:18 -0500
Subject: [PATCH 065/493] i2c: remove use of __devexit_p
In-Reply-To: <20121122214915.GD14851@pengutronix.de>
Message-ID: <20121126135218.45F6780157@viridian.itc.virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang writes:
> 
> 
> --osDK9TLjxFScVI/L
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> > On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > > needed.
> >=20
> > As mentioned on the lm-sensors list for hwmon patches already, I think
> > it would be much clearer to not split __devexit, __devexit_p, __devinit
> > etc. removal into separate patches. One patch per subsystem would be
> > easier to review and apply. If patches grow too large then you'd rather
> > split in a different direction, for example drivers/i2c/muxes vs.
> > drivers/i2c/busses or even grouped by related bus drivers (see entries
> > "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> > MAINTAINERS for examples of meaningful groups.)
> 
> I agree with Jean here. Is there a V2 planned? With a change like this?
> 

Yes, my plan is to redo the patches for the i2c subsystem.

-- 
Bill
