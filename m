From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Feb 2016 15:33:17 +0900
Subject: [PATCH v2] arm64: dts: r8a7795: Add GIC-400 virtual interfaces
In-Reply-To: <CAMuHMdVP4wA4eXK-fkENndNs=zS2vuUeDww2ZZbXvocfFiOgWQ@mail.gmail.com>
References: <1455615802-9083-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdVP4wA4eXK-fkENndNs=zS2vuUeDww2ZZbXvocfFiOgWQ@mail.gmail.com>
Message-ID: <20160217063316.GL11534@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:55:37AM +0100, Geert Uytterhoeven wrote:
> CC Marc
> 
> On Tue, Feb 16, 2016 at 10:43 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> > Besides the distributor and the CPU interface the GIC-400 additionally
> > supports the virtual interface control blocks and the virtual CPU interfaces.
> >
> > Add the physical base addresses and size for these.
> >
> > See
> >
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/index.html
> > -> 3.2. GIC-400 register map
> >
> > and Linux kernel's
> >
> > Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> >
> > for more details.
> >
> > For the at GICH Virtual interface control blocks at 0xf1040000 cover the
> > whole 128kB (0x20000) range. This is done based on the advice from Marc
> > Zyngier http://www.spinics.net/lists/arm-kernel/msg483139.html
> >
> > Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> 
> Thanks!
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.6.
