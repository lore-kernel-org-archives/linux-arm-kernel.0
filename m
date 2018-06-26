From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 26 Jun 2018 13:08:06 +0200
Subject: [PATCH 0/4] media: sun6i: Add support for the H3 CSI controller
In-Reply-To: <CAMty3ZBRYtTBiYjQNZj07Ni_bi6qH+L1xga_kcHVrW0tZ0-hLQ@mail.gmail.com>
References: <20180305100432.15009-1-maxime.ripard@bootlin.com>
 <CAMty3ZBQXyvOnzy_9RLDW-QO9qnAC4SR5UJnWYmhiPrP23z_vg@mail.gmail.com>
 <20180626082330.pvq3gi6mmokky5vl@flea>
 <CAMty3ZBRYtTBiYjQNZj07Ni_bi6qH+L1xga_kcHVrW0tZ0-hLQ@mail.gmail.com>
Message-ID: <20180626110806.mqygmu6odhcfy67h@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 02:42:11PM +0530, Jagan Teki wrote:
> On Tue, Jun 26, 2018 at 1:53 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Tue, Jun 26, 2018 at 11:41:56AM +0530, Jagan Teki wrote:
> >> On Mon, Mar 5, 2018 at 3:34 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >> > The H3 and H5 have a CSI controller based on the one previously found
> >> > in the A31, that is currently supported by the sun6i-csi driver.
> >> >
> >> > Add the compatibles to the device tree bindings and to the driver to
> >> > make it work properly.
> >> >
> >> > This obviously depends on the serie "Initial Allwinner V3s CSI
> >> > Support" by Yong Deng.
> >> >
> >> > Let me know what you think,
> >> > Maxime
> >> >
> >> > Maxime Ripard (2):
> >> >   dt-bindings: media: sun6i: Add A31 and H3 compatibles
> >> >   media: sun6i: Add A31 compatible
> >> >
> >> > Myl?ne Josserand (2):
> >> >   ARM: dts: sun8i: Add the H3/H5 CSI controller
> >> >   [DO NOT MERGE] ARM: dts: sun8i: Add CAM500B camera module to the Nano
> >> >     Pi M1+
> >>
> >> Just trying to understand what interface has been tested with npi-m1+,
> >> is it DVP (parallel) interface?
> >
> > Yes
> >
> >> I've Bananapi 5MP[1] and trying to test on top, and look like its
> >> MIPI CSI2. I guess Yong patch[2] doesn't support CSI2 yet, am I
> >> correct?
> >
> > This is what Yong's cover letter is saying yes :)
> 
> Thanks, and this ov5640 tested on -next or any specific code? please
> provide if you have different code base.

It should work with the current ov5640 driver.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
