From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Sep 2017 10:47:45 +0200
Subject: [PATCH 8/8] ARM: drs: iwg22m: Add SPI NOR support
In-Reply-To: <CAMuHMdW2_Tz6Mu7bwTXiAuyyeUvJTFrbyMAnxCi+Nj7ig65Ong@mail.gmail.com>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-9-git-send-email-chris.paterson2@renesas.com>
 <CAMuHMdW2_Tz6Mu7bwTXiAuyyeUvJTFrbyMAnxCi+Nj7ig65Ong@mail.gmail.com>
Message-ID: <20170921084744.GM15749@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 01:10:00PM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 13, 2017 at 7:05 PM, Chris Paterson
> <chris.paterson2@renesas.com> wrote:
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > Add support for the SPI NOR device used to boot up the system
> > to the System on Module DT.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> 
> With the subject fixed (s/drs/dts/):
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied as

ARM: dts: iwg22m: Add SPI NOR support
