From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Sep 2018 11:27:48 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add all MSIOF device
 nodes
In-Reply-To: <20180906092507.lz2n3xw7ksbgpges@verge.net.au>
References: <1536092561-6048-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdWjLYhMDz6YuU_Y0vHtWBgSgt5BgTz0dDq86bqR8sX-1A@mail.gmail.com>
 <20180906092507.lz2n3xw7ksbgpges@verge.net.au>
Message-ID: <CAMuHMdXgAe=AO_B2DfP1jLi1omETocJQt=C6G+WBJKNqTEDvFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Sep 6, 2018 at 11:25 AM Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 05, 2018 at 08:52:56AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 4, 2018 at 10:23 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > This patch adds the device nodes for all MSIOF SPI controllers to
> > > the R8A77990 SoC.
> > >
> > > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >
> > Thanks for your patch!
> >
> > Unfortunately this is a duplicate of
> > https://www.spinics.net/lists/devicetree/msg246988.html.
> >
> > Sorry for stepping on your toes, I added MSIOF support for Ebisu to investigate
> > MSIOF driver bugs.
>
> The DMA portions seem new.

Yes it is.

> Perhaps a new patch should be constructed that only adds those properties?

To be added after testing MSIOF DMA ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
