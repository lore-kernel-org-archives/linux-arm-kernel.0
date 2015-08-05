From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 5 Aug 2015 10:50:44 +0200
Subject: [PATCH v3 2/2] doc: dt: add documentation for nxp,lpc1788-rtc
In-Reply-To: <20150727133720.GA15004@beef>
References: <1436635730-15617-1-git-send-email-manabian@gmail.com>
 <1436635730-15617-3-git-send-email-manabian@gmail.com>
 <20150727133720.GA15004@beef>
Message-ID: <20150805085044.GC3486@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/07/2015 at 09:37:20 -0400, Matt Porter wrote :
> > +Required properties:
> > +- compatible	: must contain "nxp,lpc1788-rtc"
> > +- reg		: Specifies base physical address and size of the registers.
> > +- interrupts	: A single interrupt specifier.
> > +- clocks	: Must contain entries for rtc and register clock
> 
> "Must contain clock specifiers for rtc and register clock" ?
> 

I fixed it up in the patch.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
