From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 00:13:44 +0200
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <504EF5BF.2090404@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
 <503B7D6E.7090906@atmel.com>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D747@wm021.weinmann.com>
 <504EF5BF.2090404@atmel.com>
Message-ID: <20120911221344.GF27031@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 10:26:39AM +0200, Nicolas Ferre wrote:
> On 08/27/2012 04:29 PM, Voss, Nikolaus :
> > ludovic.desroches wrote on Monday, August 27, 2012 4:00 PM :
> >> For the moment, I don't have the necessary knowledge about the TWI
> >> controller to take a decision. I would say it can be done in an other
> >> patch in order to have your driver included in the mainline quickly
> >> since it doesn't introduce a breakage.
> > 
> > That would be the most pragmatic approach.
> > Wolfram, is the anything left to do from my side?
> 
> Wolfram, ping?
> 
> Can we imagine to have this support and the device tree patches from
> Ludovic in 3.7-final?

Yes. I'd need your ack since it touches mach-specific stuff. Reviewed-by
would be even better since you know the HW better than me :)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/48e356a0/attachment.sig>
