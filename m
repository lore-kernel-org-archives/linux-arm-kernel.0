From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 Oct 2013 09:27:28 +0800
Subject: [PATCH 3/4] ARM: dts: i.MX53: dts for Voipac x53-dmm-668 module
In-Reply-To: <1382644733.19373.2.camel@lolumad>
References: <1382461643-16790-1-git-send-email-lisovy@gmail.com>
 <1382461643-16790-4-git-send-email-lisovy@gmail.com>
 <20131023072738.GI2839@S2101-09.ap.freescale.net>
 <1382641926.16515.2.camel@lolumad>
 <CAHCPf3vB+HYkFoBYcbVM6Ecp+8BSApG2JZi1PRwc7ag6ygszOw@mail.gmail.com>
 <1382644733.19373.2.camel@lolumad>
Message-ID: <20131025012725.GG14529@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 09:58:53PM +0200, Rostislav Lisovy wrote:
> I saw that most of the vendor prefixes are somehow shortened (e.g.
> Freescale -- fsl, etc.).

The 'fsl' is the stock symbol of Freescale.  If that's not the case for
voipac, I think 'voipac' is more appropriate.

Shawn

> On Thu, 2013-10-24 at 14:49 -0500, Matt Sealey wrote: 
> > On Thu, Oct 24, 2013 at 2:12 PM, Rostislav Lisovy <lisovy@gmail.com> wrote:
> > > Dear Shawn;
> > > Thank you for your comments.
> > > Should I also add Voipac to
> > > Documentation/devicetree/bindings/vendor-prefixes.txt?
> > 
> > I would agree with that, but why is your chosen prefix "vp" instead of
> > "voipac" anyway?
> > 
> 
> 
