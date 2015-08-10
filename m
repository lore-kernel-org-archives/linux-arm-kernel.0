From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Aug 2015 08:20:58 +0900
Subject: [PATCH v3 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <CAMuHMdVj4_h8LX=XuWSyhGpSZ2BPxuWe_oJQYTRPFfYbuidm4g@mail.gmail.com>
References: <2265315.MpjeDzrVz2@wasted.cogentembedded.com>
 <10288801.ZnYt2TD47O@wasted.cogentembedded.com>
 <CAMuHMdVj4_h8LX=XuWSyhGpSZ2BPxuWe_oJQYTRPFfYbuidm4g@mail.gmail.com>
Message-ID: <20150810232054.GA9484@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 03:23:54PM +0200, Geert Uytterhoeven wrote:
> Hi Sergei,
> 
> On Sun, Aug 9, 2015 at 12:09 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Describe GPIO[0-6] controllers in the R8A7794 device tree.
> >
> > Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > ---
> > Changes in version 3:
> > - added "power-domains" property to the GPIO device nodes.
> 
> Thanks, unwithdrawing my ack ;-)
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up for v4.4.
