From: horms@verge.net.au (Simon Horman)
Date: Fri, 17 Nov 2017 06:20:18 -0800
Subject: [PATCH 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY IRQ
In-Reply-To: <CAMuHMdUqX6OhsKBET5RkL0zcZO-aiTT4wHHuwuRTeVHAYkSnZg@mail.gmail.com>
References: <20171113213152.819421744@cogentembedded.com>
 <CAMuHMdUqX6OhsKBET5RkL0zcZO-aiTT4wHHuwuRTeVHAYkSnZg@mail.gmail.com>
Message-ID: <20171117142017.g6vg7m5k2tcd7ovy@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 05:15:58PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 13, 2017 at 10:23 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
> > have the GPIO support (previously phylib had to resort to polling).
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
