From: lee@kernel.org (Lee Jones)
Date: Thu, 20 Nov 2014 11:22:55 +0000
Subject: [PATCH] ARM: bcm2835: Add device tree for Raspberry Pi model B+
In-Reply-To: <2041471.8rvf0EmQUU@wuerfel>
References: <1416480765-13449-1-git-send-email-lee@kernel.org>
 <2041471.8rvf0EmQUU@wuerfel>
Message-ID: <20141120112255.GB13269@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Nov 2014, Arnd Bergmann wrote:

> On Thursday 20 November 2014 10:52:45 Lee Jones wrote:
> > From: Matthias Klein <matthias.klein@linux.com>
> > 
> > The model B and B+ differ in the GPIO lines for ACT and PWR leds, and the
> > I2S interface.
> > 
> > Signed-off-by: Matthias Klein <matthias.klein@linux.com>
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > 
> > As requested by Arnd.
> > 
> >  arch/arm/boot/dts/Makefile               |  1 +
> >  arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 30 +++++++++++++++++++
> >  arch/arm/boot/dts/bcm2835-rpi-b.dts      | 46 ++--------------------------
> >  arch/arm/boot/dts/bcm2835-rpi.dtsi       | 51 ++++++++++++++++++++++++++++++++
> >  4 files changed, 85 insertions(+), 43 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
> >  create mode 100644 arch/arm/boot/dts/bcm2835-rpi.dtsi
> > 
> 
> Applied to next/dt.
> 
> When you send a patch for inclusion the next time, better
> be explicit and ask for it to be picked up into arm-soc, so we
> know it's not just for review.

Sounds reasonable.  Thanks Arnd.
