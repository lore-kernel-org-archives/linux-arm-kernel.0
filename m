From: horms@verge.net.au (Simon Horman)
Date: Thu, 7 Dec 2017 10:03:17 +0100
Subject: [PATCH v2] ARM: dts: r8a7745: Add APMU node and second CPU core
In-Reply-To: <CAMuHMdWTepYLpySfo6hq10-9TrGh+o=P9k5RnTYxBTe-eh-pQw@mail.gmail.com>
References: <1512561929-16540-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWTepYLpySfo6hq10-9TrGh+o=P9k5RnTYxBTe-eh-pQw@mail.gmail.com>
Message-ID: <20171207090316.kqo2iqwrkjtearuz@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 01:12:02PM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 6, 2017 at 1:05 PM, Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> >
> > Add DT node for the Advanced Power Management Unit (APMU), add the
> > second CPU core, and use "renesas,apmu" as "enable-method".
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> 
> > v2:
> > - rebased against renesas-devel-20171205-v4.15-rc2
> 
> Seems my
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> was not added.

Its added now :)

I've applied this for v4.16.
