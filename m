From: marex@denx.de (Marek Vasut)
Date: Mon, 14 Jul 2014 20:57:25 +0200
Subject: [PATCH 1/2] ARM: dts: mx5: Split M53EVK into SoM and EVK parts
In-Reply-To: <20140714144913.GA2607@dragon>
References: <1403722113-5721-1-git-send-email-marex@denx.de>
 <201407091355.34295.marex@denx.de> <20140714144913.GA2607@dragon>
Message-ID: <201407142057.25858.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 14, 2014 at 04:49:15 PM, Shawn Guo wrote:
> On Wed, Jul 09, 2014 at 01:55:34PM +0200, Marek Vasut wrote:
> > On Saturday, June 28, 2014 at 05:15:53 PM, Shawn Guo wrote:
> > > On Wed, Jun 25, 2014 at 08:48:32PM +0200, Marek Vasut wrote:
> > > > @@ -226,14 +158,11 @@
> > > > 
> > > >  &iomuxc {
> > > >  
> > > >  	pinctrl-names = "default";
> > > > 
> > > > -	pinctrl-0 = <&pinctrl_hog>;
> > > > +	pinctrl-0 = <&pinctrl_hog &pinctrl_usb>;
> > > 
> > > Hmm, shouldn't pinctrl_usb be put into some USB related node?
> > 
> > Sorry for the late reply. It should. I am sending a small patch
> > in-reply-to this one. Please either squash them together or apply in
> > sequence, as seen fit. Hopefully this will clarify the change. I will
> > send a full v2 if needed be.
> 
> Squashed and applied, thanks.

Thanks!

Best regards,
Marek Vasut
