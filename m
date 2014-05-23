From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 May 2014 09:51:06 +0900
Subject: [PATCH 2/2] ARM: shmobile: marzen dts: Remove superfluous include
In-Reply-To: <CAMuHMdXWW-2BaEpMXy3b_scttgo3S1UD73kt-dH44_s-GGf4WQ@mail.gmail.com>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
 <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
 <2352184.UXetcfavus@avalon>
 <CAMuHMdXWW-2BaEpMXy3b_scttgo3S1UD73kt-dH44_s-GGf4WQ@mail.gmail.com>
Message-ID: <20140523005106.GB8483@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 02:58:57PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 22, 2014 at 2:50 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Thursday 22 May 2014 14:33:17 Geert Uytterhoeven wrote:
> >> <dt-bindings/interrupt-controller/irq.h> is already included by
> >> r8a7779.dtsi.
> >
> > Isn't it better, like with C code, to explicitly include headers that provide
> > the macros you need, instead of relying on implicit #include's that could
> > change later ? OK, in this specific case, it's very unlikely that r8a7779.dtsi
> > would stop including <dt-bindings/interrupt-controller/irq.h>, but in the
> > general case I believe explicit includes to be good practice.
> 
> You're right. I was a bit overzealous.
> 
> Simon, please drop this.

Done.
