From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 11 Aug 2013 11:53:38 +0200
Subject: [PATCH 0/2] i2c: davinci: Couple of patches to make i2c usable
 on Keystone SOCs
In-Reply-To: <52054C7E.70108@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <52054C7E.70108@ti.com>
Message-ID: <20130811095337.GA3796@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 04:09:34PM -0400, Santosh Shilimkar wrote:
> Wolfram, Sekhar, 
> 
> On Wednesday 24 July 2013 08:28 PM, Santosh Shilimkar wrote:
> > Keystone SOCs uses the same I2C IP as available on DaVinci SOCs. These
> > couple of patches makes it possible to select the I2C_DAVINCI on
> > Keystone SOCs.
> > 
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > 
> > Santosh Shilimkar (2):
> >   i2c: davinci: remove useless mach/hardware include
> >   i2c: davinci: Allow i2c driver available for keystone platforms
> > 
> Who is queuing up these patches ?

I can pick them. Do they depend on something?
