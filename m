From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 06:50:31 -0500
Subject: [PATCH v2 15/20] arm: kirkwood: topkick: the Topkick platform
 uses a 88F6282 SoC
In-Reply-To: <20130110061309.GA9993@lunn.ch>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-16-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130110022926.GH5075@titan.lakedaemon.net>
 <20130110061309.GA9993@lunn.ch>
Message-ID: <20130110115031.GJ5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 07:13:09AM +0100, Andrew Lunn wrote:
> On Wed, Jan 09, 2013 at 09:29:26PM -0500, Jason Cooper wrote:
> > On Fri, Dec 21, 2012 at 03:49:14PM +0100, Thomas Petazzoni wrote:
> > > The Topkick board uses a 88F6282 SoC, so the Device Tree Source
> > > describing the Topkick should inherit from kirkwood-6282.dtsi, which
> > > allows to take advantage of pin muxing capabilities.
> > > 
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > ---
> > > Changes since v1:
> > >  * This patch is new in v2
> > > ---
> > >  arch/arm/boot/dts/kirkwood-topkick.dts |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
> > > index c0de5a7..8f4a5b8 100644
> > > --- a/arch/arm/boot/dts/kirkwood-topkick.dts
> > > +++ b/arch/arm/boot/dts/kirkwood-topkick.dts
> > > @@ -1,6 +1,7 @@
> > >  /dts-v1/;
> > >  
> > >  /include/ "kirkwood.dtsi"
> > > +/include/ "kirkwood-6282.dtsi"
> > 
> > Hmmm, shouldn't the cooresponding MPP.._GPIO and kirkwood_mpp_conf() be
> > removed as well?
> 
> Hi Jason
> 
> I have some patches for that. I will dig them out over the weekend.
> 
> I did have an issue with one of the LEDs. If i remember correctly, i
> sent you an email about it. Could you look back in your archive? 

Yes, I have it on my todo list.  Unfortunately, I haven't unpacked my
dev plats after my office relocation.  :(  Hopefully, I'll get that set
up this weekend.

thx,

Jason.
