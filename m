From: horms@verge.net.au (Simon Horman)
Date: Wed, 2 May 2018 08:56:42 +0200
Subject: [PATCH 07/10] ARM: dts: kzm9d: Drop unnecessary address
 properties from gpio_keys node
In-Reply-To: <20180430070747.tyc2p5xhzvv3ja6o@verge.net.au>
References: <20180426102951.8683-1-horms+renesas@verge.net.au>
 <20180426102951.8683-8-horms+renesas@verge.net.au>
 <20180426145213.GD3315@bigcity.dyn.berto.se>
 <20180430070747.tyc2p5xhzvv3ja6o@verge.net.au>
Message-ID: <20180502065641.amh6uefuv6xpxaht@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 09:07:48AM +0200, Simon Horman wrote:
> On Thu, Apr 26, 2018 at 04:52:13PM +0200, Niklas S?derlund wrote:
> > Hi Simon,
> > 
> > Thanks for your work.
> > 
> > On 2018-04-26 12:29:48 +0200, Simon Horman wrote:
> > > The gpio_keys node does not have an address and thus does not need
> > > address-cells or address size-properties.
> > > 
> > > This is flagged by dtc as follows:
> > >  # make dtbs W=1
> > >  arch/arm/boot/dts/r8a7794-silk.dtb: Warning (avoid_unnecessary_addr_size): /soc/video at e6ef0000/port: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> > 
> > This warning don't seem to match with the change nor the rest of the 
> > commit message :-)
> > 
> > With that addressed and for the whole series:
> > 
> > Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Thanks!
> 
> The fix is:
> 
> arch/arm/boot/dts/emev2-kzm9d.dtb: Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Series applied.
