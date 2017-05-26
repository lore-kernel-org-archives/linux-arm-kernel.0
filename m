From: horms@verge.net.au (Simon Horman)
Date: Fri, 26 May 2017 08:56:27 +0200
Subject: [PATCH] arm: dts: r7s72100: Add support for GR-Peach
In-Reply-To: <20170524070702.GB4253@w540>
References: <1495567254-10226-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUovD=6YfJYckoftWyJZ3eRjcKFkScj=wLhyTDSFPavgw@mail.gmail.com>
 <20170524070702.GB4253@w540>
Message-ID: <20170526065627.GE2628@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 09:07:02AM +0200, jmondi wrote:
> Hello Simon,
> 
> On Tue, May 23, 2017 at 09:25:40PM +0200, Geert Uytterhoeven wrote:
> > On Tue, May 23, 2017 at 9:20 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > > Add device tree source for Renesas GR-Peach board.
> > > GR-Peach is an RZ/A1H based board with 10MB of on-chip SRAM and 8MB
> > > QSPI flash storage.
> > > Add support for the board, and create a 2MB partition to use as rootfs.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I forgot to change subject to "PATCH v2".
> Could you please take this one, or would you like me to resend with
> Geert's reviewed-by ?

No need to repost, I've queued-up this version for v4.13.
