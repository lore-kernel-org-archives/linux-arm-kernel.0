From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 29 May 2018 11:57:57 +0200
Subject: [PATCH v10 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <20180517090224.u3ygdzjr77im2mmp@flea>
References: <20180517090224.u3ygdzjr77im2mmp@flea>
Message-ID: <20180529095757.qkz7jyuxza7movbc@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 11:02:24AM +0200, Maxime Ripard wrote:
> On Fri, May 04, 2018 at 02:44:08PM +0800, Yong Deng wrote:
> > This patchset add initial support for Allwinner V3s CSI.
> > 
> > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > interface and CSI1 is used for parallel interface. This is not
> > documented in datasheet but by test and guess.
> > 
> > This patchset implement a v4l2 framework driver and add a binding 
> > documentation for it. 
> > 
> > Currently, the driver only support the parallel interface. And has been
> > tested with a BT1120 signal which generating from FPGA. The following
> > fetures are not support with this patchset:
> >   - ISP 
> >   - MIPI-CSI2
> >   - Master clock for camera sensor
> >   - Power regulator for the front end IC
> 
> I tested it on my H3 with a parallel camera, and it still works. Thanks!
> 
> Hans, Sakari, any chance this might land in 4.18?

Ping?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
