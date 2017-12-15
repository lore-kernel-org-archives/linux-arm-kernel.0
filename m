From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Dec 2017 16:08:23 +0100
Subject: [PATCH 1/1] arm: sunxi: Add alternative pins for spi0
In-Reply-To: <5f518e4b-e624-17c2-7e72-24ba930a1c15@gmail.com>
References: <1513151074-6888-1-git-send-email-stefan@olimex.com>
 <20171213154035.qc655iahjoeflftq@flea.lan>
 <5f518e4b-e624-17c2-7e72-24ba930a1c15@gmail.com>
Message-ID: <20171215150823.jplgknururmkvp2t@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 14, 2017 at 08:24:54AM +0200, Stefan Mavrodiev wrote:
> On 12/13/2017 05:40 PM, Maxime Ripard wrote:
> > Hi,
> > 
> > On Wed, Dec 13, 2017 at 09:44:34AM +0200, Stefan Mavrodiev wrote:
> > > Allwinner A10/A13/A20 SoCs have pinmux for spi0
> > > on port C. The patch adds these pins in the respective
> > > dts includes.
> > > 
> > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > Do you have any boards that are using these?
> > 
> > We won't merge that patch if there's no users for it.
>
> A20-OLinuXino-Lime/Lime2 and A10-OLinuXino-Lime with spi flash.
> For A13 we still doesn't have that option.

If this bus is exposed on the headers, you can add those to the DT but
leave them disabled if you want. Buf if there's no users of those
nodes, our policy is not to merge them.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171215/09e5ec43/attachment.sig>
