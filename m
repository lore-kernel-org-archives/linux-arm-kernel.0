From: horms@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 12:04:15 +0100
Subject: [PATCH renesas/devel 1/4] arm64: dts: r8a7796: Use R-Car Gen 3
 fallback binding for msiof nodes
In-Reply-To: <CAMuHMdV50sQtV_Rk5Kw=dyJ=rzX3_Fq=WThjhaFU+GPbzXNhbg@mail.gmail.com>
References: <1482229959-25584-1-git-send-email-horms+renesas@verge.net.au>
 <1482229959-25584-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXpN9x5YH0tiSRxme0yySS1NpaF41_DaePzuWd+3QD=AQ@mail.gmail.com>
 <CAMuHMdV50sQtV_Rk5Kw=dyJ=rzX3_Fq=WThjhaFU+GPbzXNhbg@mail.gmail.com>
Message-ID: <20161220110415.GM19532@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 11:44:14AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 20, 2016 at 11:42 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Dec 20, 2016 at 11:32 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> >> Use recently added R-Car Gen 3 fallback binding for msiof nodes in
> >> DT for r8a7796 SoC.
> >>
> >> This has no run-time effect for the current driver as the initialisation
> >> sequence is the same for the SoC-specific binding for r8a7796 and the
> >> fallback binding for R-Car Gen 3.
> >>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> and
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have taken the liberty of only adding your second tag.
