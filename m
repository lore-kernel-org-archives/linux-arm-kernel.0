From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:57:02 +0100
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <7h1toxr0ku.fsf@deeprootsystems.com>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <1415245232-20585-3-git-send-email-wens@csie.org>
 <7h1toxr0ku.fsf@deeprootsystems.com>
Message-ID: <7205141.lqhF7e2PeF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 14:04:01 Kevin Hilman wrote:
> Chen-Yu Tsai <wens@csie.org> writes:
> 
> > From: Emilio L?pez <emilio@elopez.com.ar>
> >
> > With the new factors infrastructure in place, we can unify apb1 and
> > apb1_mux as a single clock now.
> >
> > Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> > [wens at csie.org: Change apb1 node label to "apb1"; reword commit title]
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Boot breakage in arm-soc/for-next on sun4i-a10-cubieboard and
> sun7i-a20-cubieboard2[1] was bisected down to this patch[1].
> 
> Reverting $SUBJECT on top of arm-soc gets things booting again.
> 

As this looks like it was intended as a cleanup without functional
changes, I would go ahead and revert it in next/dt.

Any objections?

	Arnd
