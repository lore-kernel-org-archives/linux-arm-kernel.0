From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Nov 2015 17:34:42 +0100
Subject: [PATCH V2] ARM: socfpga: Add support for DENX MCV SoM and MCVEVK
 baseboard
In-Reply-To: <CADhT+wfuMAdTuGoY1EqDqACkhabVV5Z0qZTLDd3rx_EdqhiKtA@mail.gmail.com>
References: <1447921918-14486-1-git-send-email-marex@denx.de>
 <CADhT+wfuMAdTuGoY1EqDqACkhabVV5Z0qZTLDd3rx_EdqhiKtA@mail.gmail.com>
Message-ID: <201511191734.42990.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 19, 2015 at 05:27:44 PM, Dinh Nguyen wrote:
> Hi Marek,

Hi!

> On Thu, Nov 19, 2015 at 2:31 AM, Marek Vasut <marex@denx.de> wrote:
> > Add support for the DENX MCV SoM and MCVEVK baseboard. The SoM contains
> > eMMC, DRAM, Altera Cyclone V SoC. The baseboard contains CAN ports, UART
> > ports, STMPE811 touchscreen controller, USB OTG port, ethernet port and
> > a lot of IO pins.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Vince Bridgers <vbridgers2013@gmail.com>
> > Cc: Alan Tull <atull@altera.com>
> > Cc: Thor Thayer <tthayer@altera.com>
> > Cc: Dinh Nguyen <dinguyen@altear.com>
> > Cc: Olof Johansson <olof@lixom.net>
> > ---
> > 
> >  arch/arm/boot/dts/Makefile                    |  1 +
> >  arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi   | 33 ++++++++++
> >  arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts | 94
> >  +++++++++++++++++++++++++++ 3 files changed, 128 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
> >  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
> > 
> > V2: Sort the DT nodes alphabetically.
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 7d3e495..8f322be 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -555,6 +555,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
> > 
> >  dtb-$(CONFIG_ARCH_SOCFPGA) += \
> >  
> >         socfpga_arria5_socdk.dtb \
> >         socfpga_arria10_socdk_sdmmc.dtb \
> > 
> > +       socfpga_cyclone5_mcvevk.dtb \
> > 
> >         socfpga_cyclone5_socdk.dtb \
> >         socfpga_cyclone5_de0_sockit.dtb \
> >         socfpga_cyclone5_sockit.dtb \
> 
> I've applied this to my tree.

Cool, thanks!

Best regards,
Marek Vasut
