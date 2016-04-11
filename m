From: horms@verge.net.au (Simon Horman)
Date: Tue, 12 Apr 2016 08:02:54 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <CAMuHMdUwuabK2Ajo5dMWEf014Xvk-1WYz4YBTw1jVScrTKSx0g@mail.gmail.com>
References: <cover.1460339328.git.horms+renesas@verge.net.au>
 <CAMuHMdUwuabK2Ajo5dMWEf014Xvk-1WYz4YBTw1jVScrTKSx0g@mail.gmail.com>
Message-ID: <20160411230253.GB1589@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 09:11:19AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Apr 11, 2016 at 3:52 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> >
> > Please consider these Renesas ARM based SoC fixes for v4.6.
> >
> >
> > Allow serial to work once again on the Porter board (Revision B) which
> > does not have the oscillator in question mounted.
> 
> Have you tested this on Porter?

I don't have working access to a porter at this time.

> I believe there's another change to be made for this revert to actually work,
> cfr. "[PATCH] ARM: dts: r8a7791: Don't disable referenced optional clocks"
> (https://lkml.org/lkml/2016/4/6/350)

Ok, understood.

Could someone verify that?
