From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Mar 2017 10:13:52 +0200
Subject: [PATCH/RFC v2 1/2] arm64: dts: r8a7795: Add support for R-Car H3
 ES2.0
In-Reply-To: <1612430.SNEha5n02K@avalon>
References: <1490362665-4422-1-git-send-email-geert+renesas@glider.be>
 <1490362665-4422-2-git-send-email-geert+renesas@glider.be>
 <1612430.SNEha5n02K@avalon>
Message-ID: <20170329081352.GF6512@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 11:48:12AM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Friday 24 Mar 2017 14:37:44 Geert Uytterhoeven wrote:
> > Update r8a7795.dtsi so it corresponds to R-Car H3 ES2.0 or later:
> >   - The following devices no longer exist on ES2.0, and are thus removed:
> >     fcpf2, fcpvd3, fcpvi2, fdp1-2, usb3-if1, vspd3, vspi2.
> >   - The DU <-> VSPD topology is different on ES2.0, hence remove the
> >     "vsps" property from the DU node until the driver can handle this.
> 
> I think I'll need a different compatible string between ES1.x and ES2 for the 
> DU. It could make sense to move the whole DU node to *-es1.dtsi. We can decide 
> about that later when I'll have a DU driver prototype ready.

That makes sense to me.

Geert, will you respin this?
