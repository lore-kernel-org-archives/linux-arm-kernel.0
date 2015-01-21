From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 21 Jan 2015 19:15:31 +0000
Subject: [PATCH v2] drm/i2c: tda998x: Set the CEC I2C address based on
 the slave I2C address.
In-Reply-To: <20150121184658.GX26493@n2100.arm.linux.org.uk>
References: <545C835D.1050008@arm.com>
 <20150121184405.GI10762@e106497-lin.cambridge.arm.com>
 <20150121184658.GX26493@n2100.arm.linux.org.uk>
Message-ID: <20150121191531.GJ10762@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 06:46:58PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 21, 2015 at 06:44:05PM +0000, Liviu Dudau wrote:
> > On Fri, Nov 07, 2014 at 08:31:25AM +0000, Andrew Jackson wrote:
> > > The I2C address for the TDA9989 and TDA19989 is fixed at 0x34
> > > but the two LSBs of the TDA19988's address are set by two configuration
> > > pins on the chip.  Irrespective of the chip, the associated CEC
> > > peripheral's I2C address is based upon the main I2C address.
> > > 
> > > This patch avoids any special handling required to support
> > > systems that contain multiple TDA19988 devices on the same
> > > I2C bus.
> > > 
> > > Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > 
> > Hi Andrew,
> > 
> > What is the status of this patch? Is it going to be pulled by anyone?
> 
> It's been sent to David.

Thanks, Russell!

Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
