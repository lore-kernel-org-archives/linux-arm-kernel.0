From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Jun 2017 19:40:26 +0200
Subject: [PATCH v2] gpio: rcar: Add R8A7743 (RZ/G1M) support
In-Reply-To: <CAMuHMdVW6gU8GTf5v6xq0sYMgYqCaOaHcu1Ap1FDw14bUJih+A@mail.gmail.com>
References: <1497619944-61410-1-git-send-email-biju.das@bp.renesas.com>
 <1498055229-42052-1-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVW6gU8GTf5v6xq0sYMgYqCaOaHcu1Ap1FDw14bUJih+A@mail.gmail.com>
Message-ID: <20170626174025.GE26156@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 10:13:00AM +0200, Geert Uytterhoeven wrote:
> On Wed, Jun 21, 2017 at 4:27 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Renesas RZ/G1M (R8A7743) SoC GPIO blocks are identical to the R-Car Gen2
> > family. Add support for its GPIO controllers.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Although I think the time has come for family-specific compatible values
> for R-Car Gen2 and Gen3.

Yes, agreed.
