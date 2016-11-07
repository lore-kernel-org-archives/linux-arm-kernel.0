From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 07 Nov 2016 15:23:26 +0100
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog
 reset
In-Reply-To: <CAOMZO5C+3rCnpQvonXyDaMmUxsDYAnXRBXrUwbP3AT5TbofSgQ@mail.gmail.com>
References: <1427377198.3378.16.camel@pengutronix.de>
 <20161106153117.GA22538@frolo.macqel>
 <CAOMZO5ADK9TvQiBs8HrKjNp+avZsO9xujZvG6CO2onZdAcDSGA@mail.gmail.com>
 <1478514883.12872.2.camel@pengutronix.de>
 <CAOMZO5C+3rCnpQvonXyDaMmUxsDYAnXRBXrUwbP3AT5TbofSgQ@mail.gmail.com>
Message-ID: <1478528606.12872.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 07.11.2016, 10:15 -0200 schrieb Fabio Estevam:
> Hi Lucas,
> 
> On Mon, Nov 7, 2016 at 8:34 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > The problem is definitely present in current mainline Linux. I intent to
> > remove this workaround from the kernel, but we need to make sure that
> > the bootloader properly disables PCIe before jumping to the kernel
> > image.
> >
> > I don't know what the status of this is in U-Boot, but Barebox already
> > does this correctly.
> >
> > Fabio, would you mind to port this coed to U-Boot, or at least check if
> > it does the right thing?
> 
> Sure, could you point me to the Barebox fix so I can take a look?
> 
Sure,

https://git.pengutronix.de/cgit/barebox/commit/?id=f1da98da2760c21487bbba8f7fb957c843a22896

Regards,
Lucas
