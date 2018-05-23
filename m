From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 23 May 2018 10:18:30 +0200
Subject: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
In-Reply-To: <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
 <20180522143044.pgwawojiwnk2lzxb@flea>
 <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
Message-ID: <20180523081830.4ly6sj34reabbttn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 11:44:56AM +0530, Jagan Teki wrote:
> On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> >> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> >> - Allwinner A64 Cortex-A53
> >> - Mali-400MP2 GPU
> >> - AXP803 PMIC
> >> - 1GB DDR3 RAM
> >> - 8GB eMMC
> >> - AP6330 Wifi/BLE
> >> - MIPI-DSI
> >> - CSI: OV5640 sensor
> >> - USB OTG
> >
> > You claim that this is doing OTG...
> >
> > [..]
> >
> >> +&usb_otg {
> >> +     dr_mode = "peripheral";
> >> +     status = "okay";
> >> +};
> >
> > ... and yet you're setting it as peripheral...
> 
> Though it claims OTG, board doesn't have any USB ports to operate(not
> even Mini-AB) the only way to use the board as peripheral to transfer
> images from host.

I'm not sure what you mean here. If there's no USB connector, why do
you even enable it?

maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/aa60090a/attachment.sig>
