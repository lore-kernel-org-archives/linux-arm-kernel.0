From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Wed, 30 May 2018 12:19:34 +0300
Subject: [PATCH v10 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <20180529095757.qkz7jyuxza7movbc@flea.home>
References: <20180517090224.u3ygdzjr77im2mmp@flea>
 <20180529095757.qkz7jyuxza7movbc@flea.home>
Message-ID: <20180530091934.tbd6xbyr5s3ipn3v@paasikivi.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 11:57:57AM +0200, Maxime Ripard wrote:
> On Thu, May 17, 2018 at 11:02:24AM +0200, Maxime Ripard wrote:
> > On Fri, May 04, 2018 at 02:44:08PM +0800, Yong Deng wrote:
> > > This patchset add initial support for Allwinner V3s CSI.
> > > 
> > > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > > interface and CSI1 is used for parallel interface. This is not
> > > documented in datasheet but by test and guess.
> > > 
> > > This patchset implement a v4l2 framework driver and add a binding 
> > > documentation for it. 
> > > 
> > > Currently, the driver only support the parallel interface. And has been
> > > tested with a BT1120 signal which generating from FPGA. The following
> > > fetures are not support with this patchset:
> > >   - ISP 
> > >   - MIPI-CSI2
> > >   - Master clock for camera sensor
> > >   - Power regulator for the front end IC
> > 
> > I tested it on my H3 with a parallel camera, and it still works. Thanks!
> > 
> > Hans, Sakari, any chance this might land in 4.18?
> 
> Ping?

I'll try to look into this soonish but it seems to be too late for 4.18.
Sorry about that.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
