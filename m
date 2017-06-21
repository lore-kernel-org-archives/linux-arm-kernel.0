From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Jun 2017 13:33:56 +0200
Subject: [PATCH] ARM: dts: iwg20d-q7: Add pinctl support for scif0
In-Reply-To: <CAMuHMdVe7sRcGohSPvSUrryNMetddomoMbN7ffOtq9Y3DBt=zQ@mail.gmail.com>
References: <1497625049-46802-1-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdVe7sRcGohSPvSUrryNMetddomoMbN7ffOtq9Y3DBt=zQ@mail.gmail.com>
Message-ID: <20170621113354.GC17965@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 10:42:18AM +0200, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Fri, Jun 16, 2017 at 4:57 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Adding pinctrl support for scif0 interface.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> The patch looks good to me, but without schematics, we cannot verify the
> actual pins used.
> 
> Are the schematics somewhere available? Having access to them would allow us
> doing a better job reviewing your DTS patches.

Echoing Geert's request, it would be great to be able to compare the
DT description against some documentation.

My understanding is that this patch depends on "[PATCH v2 0/3] Add
R8A7743/SK-RZG1M PFC support" which in turn depends on pfc driver support
which is on target to be included in v4.13-rc1.

Accordingly I have marked this patch as deferred. Please repost
or otherwise ping me once the driver dependency is present in an rc release.
Thanks.
