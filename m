From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Apr 2015 11:42:29 +0100
Subject: [RESEND PATCH 4/8] layerscape/ftm: Add compatible string for
 FTM0 be used as alarm timer.
In-Reply-To: <BN1PR03MB1881AD322072E34DAC380259DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1427888858-29636-1-git-send-email-bhupesh.sharma@freescale.com>
 <1427888858-29636-5-git-send-email-bhupesh.sharma@freescale.com>
 <20150401132400.GF11403@leverpostej>
 <BN1PR03MB1881AD322072E34DAC380259DEF0@BN1PR03MB188.namprd03.prod.outlook.com>
Message-ID: <20150421104228.GC8544@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > +	ftm0: ftm0 at 2800000 {
> > > +		compatible = "fsl,ftm-alarm";
> > > +		reg = <0x0 0x2800000 0x0 0x10000>;
> > > +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > > +	};
> > 
> > Missing properties?
> > 
> 
> The FTM0 alarm timer only need "compatible", "reg" and "interrupts" properties.
> I miss something about the properties?

As far as I could tell from the original patch, clocks were also listed
as required properties regardless.

Mark.
