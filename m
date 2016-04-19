From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Apr 2016 08:54:48 +1000
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <1461057123.8777.31.camel@collabora.co.uk>
References: <cover.1460339328.git.horms+renesas@verge.net.au>
 <CAMuHMdUwuabK2Ajo5dMWEf014Xvk-1WYz4YBTw1jVScrTKSx0g@mail.gmail.com>
 <20160411230253.GB1589@verge.net.au>
 <20160418041206.GC3578@verge.net.au>
 <1461057123.8777.31.camel@collabora.co.uk>
Message-ID: <20160419225448.GD9826@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 11:12:03AM +0200, Sjoerd Simons wrote:
> Hey Simon,
> On Mon, 2016-04-18 at 14:12 +1000, Simon Horman wrote:
> > Hi Geert, Hi Sjoerd,
> > 
> > On Tue, Apr 12, 2016 at 08:02:54AM +0900, Simon Horman wrote:
> > > 
> > > On Mon, Apr 11, 2016 at 09:11:19AM +0200, Geert Uytterhoeven wrote:
> > > > 
> > > > Hi Simon,
> > > > 
> > > > On Mon, Apr 11, 2016 at 3:52 AM, Simon Horman
> > > > <horms+renesas@verge.net.au> wrote:
> > > > > 
> > > > > Hi Olof, Hi Kevin, Hi Arnd,
> > > > > 
> > > > > Please consider these Renesas ARM based SoC fixes for v4.6.
> > > > > 
> > > > > 
> > > > > Allow serial to work once again on the Porter board (Revision
> > > > > B) which
> > > > > does not have the oscillator in question mounted.
> > > > Have you tested this on Porter?
> > > I don't have working access to a porter at this time.
> > > 
> > > > 
> > > > I believe there's another change to be made for this revert to
> > > > actually work,
> > > > cfr. "[PATCH] ARM: dts: r8a7791: Don't disable referenced
> > > > optional clocks"
> > > > (https://lkml.org/lkml/2016/4/6/350)
> > > Ok, understood.
> > > 
> > > Could someone verify that?
> > I have added "ARM: dts: r8a7791: Don't disable referenced optional
> > clocks"
> > to the fixes-for-v4.6 branch and plan to push it in a fresh renesas-
> > next
> > tag a little later today.
> > 
> > I would appreciate any review and/or testing on porter of that
> branch.
> 
> I've tested this branch (top commit?3d7277614d29) on a Porter revision
> B board and can confirm the serial console works as expected.
> 
> Feel free to add:
> ? Tested-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Thanks, that is really helpful!

I think I will leave out the extra tag as the patches
in question are already signed off by you.
