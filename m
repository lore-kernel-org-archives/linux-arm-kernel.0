From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Jul 2017 10:44:00 +0200
Subject: [linux-sunxi] Re: [PATCH 1/2] pinctrl: sunxi: add a missing
 function of A10/A20 pinctrl driver
In-Reply-To: <a55741a065b818d8ff3843471da61c0e@aosc.io>
References: <20170706142822.20296-1-icenowy@aosc.io>
 <20170706142822.20296-2-icenowy@aosc.io>
 <20170706204646.3akr57fo6c2ok4wn@flea>
 <a55741a065b818d8ff3843471da61c0e@aosc.io>
Message-ID: <20170710084400.wwrfjekv2fkoqvoa@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 07:21:19AM +0800, icenowy at aosc.io wrote:
> ? 2017-07-07 04:46?Maxime Ripard ???
> > Hi,
> > 
> > On Thu, Jul 06, 2017 at 10:28:21PM +0800, Icenowy Zheng wrote:
> > > The PH16 pin has a function with mux id 0x5, which is the DET pin of
> > > the
> > > "sim" (smart card reader) IP block.
> > > 
> > > This function is missing both in the old A10 and A20 drivers, so it's
> > > not found during the merge of these two drivers.
> > > 
> > > Add it to the driver. As we now merged A20 pinctrl driver to the A10
> > > one, we need to only fix the A10 driver now.
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > 
> > I'm not sure what you mean there. It's not mentionned in the A10
> > datasheet, and neither in the A20. Where did you get that info from?
> 
> It's mentioned in all newest datasheets: "A10 Datasheet V1.70.pdf" and
> "A20 Datasheet V1.41 20131230.pdf".

Mentionning that in the commit log would be great.

Where did you find those?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/fad48da0/attachment.sig>
