From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 26 Jun 2018 11:41:56 +0530
Subject: [PATCH 0/4] media: sun6i: Add support for the H3 CSI controller
In-Reply-To: <20180305100432.15009-1-maxime.ripard@bootlin.com>
References: <20180305100432.15009-1-maxime.ripard@bootlin.com>
Message-ID: <CAMty3ZBQXyvOnzy_9RLDW-QO9qnAC4SR5UJnWYmhiPrP23z_vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 3:34 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> Hi,
>
> The H3 and H5 have a CSI controller based on the one previously found
> in the A31, that is currently supported by the sun6i-csi driver.
>
> Add the compatibles to the device tree bindings and to the driver to
> make it work properly.
>
> This obviously depends on the serie "Initial Allwinner V3s CSI
> Support" by Yong Deng.
>
> Let me know what you think,
> Maxime
>
> Maxime Ripard (2):
>   dt-bindings: media: sun6i: Add A31 and H3 compatibles
>   media: sun6i: Add A31 compatible
>
> Myl?ne Josserand (2):
>   ARM: dts: sun8i: Add the H3/H5 CSI controller
>   [DO NOT MERGE] ARM: dts: sun8i: Add CAM500B camera module to the Nano
>     Pi M1+

Just trying to understand what interface has been tested with npi-m1+,
is it DVP (parallel) interface? I've Bananapi 5MP[1] and trying to
test on top, and look like its MIPI CSI2. I guess Yong patch[2]
doesn't support CSI2 yet, am I correct?

[1] https://www.amazon.in/Generic-V3-0-BPI-M3-camera-chipset/dp/B0727N5CD1
[2] https://patchwork.kernel.org/patch/10380067/

Jagan.

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.
