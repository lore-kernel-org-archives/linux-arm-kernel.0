From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 10:26:39 +0200
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D090EC3D747@wm021.weinmann.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
 <503B7D6E.7090906@atmel.com>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D747@wm021.weinmann.com>
Message-ID: <504EF5BF.2090404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2012 04:29 PM, Voss, Nikolaus :
> ludovic.desroches wrote on Monday, August 27, 2012 4:00 PM :
>> For the moment, I don't have the necessary knowledge about the TWI
>> controller to take a decision. I would say it can be done in an other
>> patch in order to have your driver included in the mainline quickly
>> since it doesn't introduce a breakage.
> 
> That would be the most pragmatic approach.
> Wolfram, is the anything left to do from my side?

Wolfram, ping?

Can we imagine to have this support and the device tree patches from
Ludovic in 3.7-final?

Bye,
-- 
Nicolas Ferre
