From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Wed, 24 May 2017 08:12:15 +0200
Subject: [PATCH v2] ARM: dts: mvebu: add support for Linksys WRT3200ACM
 (Rango)
In-Reply-To: <20170524013753.GA3770@lunn.ch>
References: <20170523212921.16684-1-ralph.sennhauser@gmail.com>
 <20170524013753.GA3770@lunn.ch>
Message-ID: <20170524081215.6fa37f4f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 May 2017 03:37:53 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> Hi Ralph
> 
> > Changes since v1:
> > 
> >   - Use non-removable with the sdhci node  
> 
> ..
> 
> > +
> > +&sdhci {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&sdhci_pins>;
> > +	no-1-8-v;
> > +	broken-cd;
> > +	wp-inverted;
> > +	bus-width = <8>;
> > +	status = "okay";
> > +};  
> 
> ???
> 
> 	Andrew

Arg, forgot to squash the --fixup for this one

Ralph
