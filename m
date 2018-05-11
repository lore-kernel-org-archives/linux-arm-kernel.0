From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 11 May 2018 16:57:58 +0200
Subject: [PATCH v2] arm64: allwinner: a64: Add Amarula A64 Relic initial
 support
In-Reply-To: <CAMty3ZCM7Sxsp4MwDRYq9NSfWJfj6XKK6JN9DKyk91MNrLvPAg@mail.gmail.com>
References: <20180511054307.3410-1-jagan@amarulasolutions.com>
 <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
 <CAMty3ZCM7Sxsp4MwDRYq9NSfWJfj6XKK6JN9DKyk91MNrLvPAg@mail.gmail.com>
Message-ID: <20180511145758.z3ufqu3njnm7kb2m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 11:37:04AM +0530, Jagan Teki wrote:
> On Fri, May 11, 2018 at 11:20 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> > On Thu, May 10, 2018 at 10:43 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> >> Amarula A64 Relic is Allwinner A64 based IoT device, which support
> >> - Allwinner A64 Cortex-A53
> >> - Mali-400MP2 GPU
> >> - AXP803 PMIC
> >> - 1GB DDR3 RAM
> >> - 8GB eMMC
> >> - AP6330 Wifi/BLE
> >> - MIPI-DSI
> >> - CSI: OV5640 sensor
> >> - USB OTG
> >> - 12V DC power supply
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >> Changes for v2:
> >> - Rename dts name to sun50i-a64-relic.dts which is simple to use
> >
> > This is subjective. For other users this hardly qualifies to
> > identify the board. Please keep the vendor / brand name in
> > the file name.
> 
> Which I thought initially, but adding vendor makes long string which
> become lengthy for next boards to add it in future. So we make
> notation with <SOC_name>_<board_name> like sun50i-a64-teres-i.dts
> does.

In the case of Teres-I, this is an easily identifiable board, for
which a simple google search can give you very easily what board it is
and where you can get it. Yours fail for both, so I agree with Chen-Yu
here.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180511/19c6f9d6/attachment.sig>
