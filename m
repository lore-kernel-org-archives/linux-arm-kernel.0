From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Aug 2017 10:00:08 +0200
Subject: [PATCH v3] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <20170821124305.GA4276@katana>
References: <CAMuHMdWUxxp75u1VSLY3WnObmhSMDvP3skr9Uf3rV4Bf-ixy_w@mail.gmail.com>
 <1503318311-48664-1-git-send-email-biju.das@bp.renesas.com>
 <20170821124305.GA4276@katana>
Message-ID: <20170822080008.GE30838@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 02:43:05PM +0200, Wolfram Sang wrote:
> On Mon, Aug 21, 2017 at 01:25:11PM +0100, Biju Das wrote:
> > Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> > is identical to the R-Car Gen2 family.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Its probably time for some fallback compatibility strings but
I think that should be done as follow-up (likely by me) in a considered
way. So this patch is fine in my books.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
