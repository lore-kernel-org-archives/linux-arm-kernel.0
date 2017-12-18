From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 10:28:14 +0100
Subject: [PATCH 1/1] arm: sunxi: Add alternative pins for spi0
In-Reply-To: <ca648552-cefb-e19d-72cf-8b56e97b013d@gmail.com>
References: <1513151074-6888-1-git-send-email-stefan@olimex.com>
 <20171213154035.qc655iahjoeflftq@flea.lan>
 <5f518e4b-e624-17c2-7e72-24ba930a1c15@gmail.com>
 <20171215150823.jplgknururmkvp2t@flea.lan>
 <ca648552-cefb-e19d-72cf-8b56e97b013d@gmail.com>
Message-ID: <20171218092814.n5ptd5mhvo4nkjgq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 08:24:21AM +0200, Stefan Mavrodiev wrote:
> On 12/15/2017 05:08 PM, Maxime Ripard wrote:
> > Hi,
> > 
> > On Thu, Dec 14, 2017 at 08:24:54AM +0200, Stefan Mavrodiev wrote:
> > > On 12/13/2017 05:40 PM, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Dec 13, 2017 at 09:44:34AM +0200, Stefan Mavrodiev wrote:
> > > > > Allwinner A10/A13/A20 SoCs have pinmux for spi0
> > > > > on port C. The patch adds these pins in the respective
> > > > > dts includes.
> > > > > 
> > > > > Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> > > > Do you have any boards that are using these?
> > > > 
> > > > We won't merge that patch if there's no users for it.
> > > A20-OLinuXino-Lime/Lime2 and A10-OLinuXino-Lime with spi flash.
> > > For A13 we still doesn't have that option.
> > If this bus is exposed on the headers, you can add those to the DT but
> > leave them disabled if you want. Buf if there's no users of those
> > nodes, our policy is not to merge them.
>
> So basically I should resend the patch, enabling the those pins only for
> sun4i and sun7i platform?

I'm not quite sure what you mean, but you should do something like
77df9d66b0b1ad01c685fd6341ce501493899658

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/717315d0/attachment.sig>
