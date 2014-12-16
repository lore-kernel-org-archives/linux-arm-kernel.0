From: evgeni@studio-punkt.com (Evgeni Dobrev)
Date: Tue, 16 Dec 2014 19:19:13 +0100
Subject: [PATCH 1/2] ARM: dts: kirkwood: enable phy driver for SATA
 controller on 88f6192
In-Reply-To: <20141216170138.14dcabc1@free-electrons.com>
References: <20141215203724.GA22936@anne>
 <20141216170138.14dcabc1@free-electrons.com>
Message-ID: <20141216181913.GF20170@anne>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Tue, Dec 16, 2014 at 05:01:38PM +0100, Thomas Petazzoni wrote:
> Dear Evgeni Dobrev,
> 
> On Mon, 15 Dec 2014 21:37:24 +0100, Evgeni Dobrev wrote:
> > This patch enables the phy drivers for the SATA controller on Marvell's 88f6192. Without them it is not possible to use SATA drives attached to this processor.
> 
> Commit log text should be wrapped to some reasonable length.
> 

I will fix this.

> 
> >  			interrupts = <21>;
> >  			clocks = <&gate_clk 14>, <&gate_clk 15>;
> >  			clock-names = "0", "1";
> > +                        phys = <&sata_phy0>, <&sata_phy1>;
> > +                        phy-names = "port0", "port1";
> 
> You should use tabs and not spaces for indentation in Device Tree files.

I will resubmit. Thank you for your review.

> 
> Thanks!
> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> --

evgeni
