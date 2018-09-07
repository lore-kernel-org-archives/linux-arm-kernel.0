From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 15:23:11 +0200
Subject: [PATCH v10 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <CAGb2v67RP8bjObBJu_1JsREUo64hnEzptG_n-aYMn4Dcd_Zo-g@mail.gmail.com>
References: <20180517090224.u3ygdzjr77im2mmp@flea>
 <20180529095757.qkz7jyuxza7movbc@flea.home>
 <20180530091934.tbd6xbyr5s3ipn3v@paasikivi.fi.intel.com>
 <CAGb2v67RP8bjObBJu_1JsREUo64hnEzptG_n-aYMn4Dcd_Zo-g@mail.gmail.com>
Message-ID: <20180907132311.g7q3zzziiagqecae@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Wed, Jun 20, 2018 at 12:45:03PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 30, 2018 at 5:19 PM, Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Tue, May 29, 2018 at 11:57:57AM +0200, Maxime Ripard wrote:
> >> On Thu, May 17, 2018 at 11:02:24AM +0200, Maxime Ripard wrote:
> >> > On Fri, May 04, 2018 at 02:44:08PM +0800, Yong Deng wrote:
> >> > > This patchset add initial support for Allwinner V3s CSI.
> >> > >
> >> > > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> >> > > interface and CSI1 is used for parallel interface. This is not
> >> > > documented in datasheet but by test and guess.
> >> > >
> >> > > This patchset implement a v4l2 framework driver and add a binding
> >> > > documentation for it.
> >> > >
> >> > > Currently, the driver only support the parallel interface. And has been
> >> > > tested with a BT1120 signal which generating from FPGA. The following
> >> > > fetures are not support with this patchset:
> >> > >   - ISP
> >> > >   - MIPI-CSI2
> >> > >   - Master clock for camera sensor
> >> > >   - Power regulator for the front end IC
> >> >
> >> > I tested it on my H3 with a parallel camera, and it still works. Thanks!
> >> >
> >> > Hans, Sakari, any chance this might land in 4.18?
> >>
> >> Ping?
> >
> > I'll try to look into this soonish but it seems to be too late for 4.18.
> > Sorry about that.
> 
> Can we get this into 4.19?

Did you have some time to make the changes Sakari asked for? That
would be great to have it in 4.20.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/9d2a6c9a/attachment.sig>
