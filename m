From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 May 2018 20:48:43 +0200
Subject: [PATCH 00/10] ARM, arm64: dts: renesas: update register properties
In-Reply-To: <CAMuHMdUBtNrny+DPqamKSL6nmiyuF38BQdD0eqc7kzDhuMSQqg@mail.gmail.com>
References: <20180426102951.8683-1-horms+renesas@verge.net.au>
 <CAMuHMdUBtNrny+DPqamKSL6nmiyuF38BQdD0eqc7kzDhuMSQqg@mail.gmail.com>
Message-ID: <20180509184842.b33k2sviyj7y4p4y@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 03:10:18PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Apr 26, 2018 at 12:29 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > this series:
> >
> > 1. Drops unnecessary address properties from VIN port nodes
> >    on Renesas R-Car Gen2 SoC board DTSes. These are unnecessary
> >    as the nodes to not have bus addresses.
> 
> I guess the example in Documentation/devicetree/bindings/media/rcar_vin.txt
> should be updated, too?

I have sent a patch for this.

> > 2. And adds address properties to R-Car Sound port nodes on
> >    Renesas R-Car Gen2 SoC DTSes. These are necessary as the nodes
> >    have unit names.
> 
> Documentation/devicetree/bindings/sound/renesas,rsnd.txt doesn't say
> anything about the presence of ports?
