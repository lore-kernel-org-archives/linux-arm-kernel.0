From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 Aug 2017 11:51:43 +0200
Subject: [PATCH 0/4] arm64: dts: renesas: Add Support for R-Car D3 and
 Draak
In-Reply-To: <CAMuHMdXLVXaN+X0yKuO+xdZGi3MwM4vSP1uTLuS9SKFKg_UBDA@mail.gmail.com>
References: <1500555277-22921-1-git-send-email-geert+renesas@glider.be>
 <20170727151622.GG16143@verge.net.au>
 <CAMuHMdXLVXaN+X0yKuO+xdZGi3MwM4vSP1uTLuS9SKFKg_UBDA@mail.gmail.com>
Message-ID: <20170817095142.GC25223@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 11:47:33AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jul 27, 2017 at 5:16 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jul 20, 2017 at 02:54:33PM +0200, Geert Uytterhoeven wrote:
> >> This patch series adds minimal support for the R-Car D3 SoC and the
> >> Draak development board, allowing to boot from a ramdisk using a serial
> >> console.
> >>
> >>   - The first two patches add DT sources for R-Car D3 and Draak.
> >>     Due to the use of hardcoded constants, they have no further (build)
> >>     dependencies (obviously there is a runtime dependency).
> >>   - The last two patches replace the hardcoded constants by symbols from
> >>     DT binding headers, and thus depend on those headers.  Hence it
> >>     should be postponed to v4.15.
> 
> > So I have applied the first two patches for v4.14.
> 
> Thank you!
> 
> > Please repost the remaining two after v4.13-rc6 at which time I should
> > be able to queue them up for v4.15.
> 
> You mean after v4.14-rc1? Else you still won't have them in renesas-devel.

I was thinking I could merge a stable branch in after v4.13-rc6.
But waiting for v4.14-rc1 is simpler for me.
