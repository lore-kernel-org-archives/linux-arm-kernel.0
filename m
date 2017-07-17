From: martin@kaiser.cx (Martin Kaiser)
Date: Mon, 17 Jul 2017 23:05:23 +0200
Subject: [PATCH v2 2/3] ARM: i.MX25: add RNGC node to dtsi
In-Reply-To: <20160401085259.GH18833@tiger>
References: <1457705200-16951-1-git-send-email-s.trumtrar@pengutronix.de>
 <1457705200-16951-2-git-send-email-s.trumtrar@pengutronix.de>
 <20160401085259.GH18833@tiger>
Message-ID: <20170717210523.GC15429@reykholt.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

I'd like to pick this up and get the rgnc driver merged.

Thus wrote Shawn Guo (shawnguo at kernel.org):

> > +			rng: rng at 53fb0000 {
> > +				compatible = "fsl,imx25-rng";
> > +				reg = <0x53fb0000 0x4000>;
> > +				clocks = <&clks 109>;
> > +				clock-names = "ipg";

> I think clock-names can be dropped too.

done. I'll upload a new version shortly.

Best regards,
Martin
