From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 07:25:03 -0700
Subject: [PATCH 2/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 comments etc.
In-Reply-To: <20170418141312.GD27592@e104818-lin.cambridge.arm.com>
References: <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
 <1491291844.6218.25.camel@infradead.org>
 <20170404092604.GB14898@arm.com>
 <1492085938.20068.6.camel@infradead.org>
 <20170416231223.GA31693@verge.net.au>
 <CAMuHMdXTgCEesv3imtnzs6Mcnkp22KW_rx0Jiv3_zce7bR3AVQ@mail.gmail.com>
 <20170418141312.GD27592@e104818-lin.cambridge.arm.com>
Message-ID: <20170419142503.GC12105@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 03:13:12PM +0100, Catalin Marinas wrote:
> On Mon, Apr 17, 2017 at 01:54:49PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Apr 17, 2017 at 1:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Thu, Apr 13, 2017 at 01:18:58PM +0100, David Woodhouse wrote:
> > >> Less important than in user-visible messages, but still good practice as
> > >> there's still no excuse for ARM64 code to look like it was written before
> > >> 1996.
> > >>
> > >> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > Hi David,
> > >
> > > I'd be happy to take the Renesas portions of this change if they were
> > > broken out into a separate patch. The reason I would prefer a separate
> > > patch is to avoid the possibility of conflicts, even trivial ones.
> > 
> > s/possibility/reality/, unless this series goes in before v4.12-rc1.
> 
> Maybe the arm-soc guys can take both patches on top of the other series
> they pull, in which case, for both patches:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Sure, please resend to arm at kernel.org with collected acks.

-Olo
