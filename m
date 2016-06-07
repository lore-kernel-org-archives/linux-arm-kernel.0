From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Tue, 7 Jun 2016 17:27:29 +0530
Subject: [PATCH v4 3/7] binding: mdio-mux: Add DT binding doc for Broadcom
 MDIO bus multiplexer
In-Reply-To: <5755C290.2020704@gmail.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-4-git-send-email-pramod.kumar@broadcom.com>
 <5755C290.2020704@gmail.com>
Message-ID: <f6cd5df22ef8ea070d7b35e628b6d25a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 07 June 2016 00:06
> To: Pramod Kumar; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Catalin Marinas; Will Deacon; Kishon Vijay Abraham I; David S.
> Miller
> Cc: devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 3/7] binding: mdio-mux: Add DT binding doc for
> Broadcom MDIO bus multiplexer
>
> On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> > Add DT binding doc for Broadcom MDIO bus multiplexer driver.
> >
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
>
>
> > +for example:
> > +		mdio_mux_iproc: mdio-mux at 6602023c {
>
> I think Rob wanted you to drop the underscores here in favor of dashes,
> there
> are more below, not critical imho.
>

I'd changed node name in favor of dashes. I don't think Label could be
written with hyphens,"-".  "-" in label provides DT parsing error.


> > +			compatible = "brcm,mdio-mux-iproc";
> > +			reg = <0x6602023c 0x14>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			mdio at 0 {
> > +				reg = <0x0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pci_phy0: pci-phy at 0 {
>
>
> --
> Florian

Regards,
Pramod
