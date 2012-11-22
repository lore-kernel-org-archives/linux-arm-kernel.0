From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 22 Nov 2012 22:49:15 +0100
Subject: [PATCH 065/493] i2c: remove use of __devexit_p
In-Reply-To: <20121120144621.5d2c213a@endymion.delvare>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
 <20121120144621.5d2c213a@endymion.delvare>
Message-ID: <20121122214915.GD14851@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > needed.
> 
> As mentioned on the lm-sensors list for hwmon patches already, I think
> it would be much clearer to not split __devexit, __devexit_p, __devinit
> etc. removal into separate patches. One patch per subsystem would be
> easier to review and apply. If patches grow too large then you'd rather
> split in a different direction, for example drivers/i2c/muxes vs.
> drivers/i2c/busses or even grouped by related bus drivers (see entries
> "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> MAINTAINERS for examples of meaningful groups.)

I agree with Jean here. Is there a V2 planned? With a change like this?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/afe44b96/attachment.sig>
