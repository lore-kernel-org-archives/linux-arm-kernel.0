From: LeoLi@freescale.com (Li Leo)
Date: Tue, 22 Sep 2015 22:39:16 +0000
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <20150922221504.GA1497@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <20150922221504.GA1497@svinekod>
Message-ID: <DM2PR0301MB07348FE1F1D12B19FF5084EEBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > > +       ifc: ifc at 1530000 {
> > > > +               compatible = "fsl,ifc", "simple-bus";
> > > > +               reg = <0x0 0x1530000 0x0 0x10000>;
> > > > +               interrupts = <0 43 0x4>;
> > > > +       };
> > >
> > > Why simple-bus?
> >
> > There are 3 child node located in dtsi file that should be created and
> > added to platform device list.
> 
> Are they usable even if the kernel knew nothing about the IFC node? If not, the
> IFC driver should probe them, and simple-bus should go.

Adding the IFC driver owner to the loop.

Regards,
Leo
