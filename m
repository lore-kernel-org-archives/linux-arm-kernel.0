From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Nov 2014 11:04:36 +0100
Subject: [PATCH resend 2/4] ARM: dts: sunxi: unify APB1 clock
In-Reply-To: <7h1toxr0ku.fsf@deeprootsystems.com>
References: <1415245232-20585-1-git-send-email-wens@csie.org>
 <1415245232-20585-3-git-send-email-wens@csie.org>
 <7h1toxr0ku.fsf@deeprootsystems.com>
Message-ID: <20141121100436.GB4752@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 02:04:01PM -0800, Kevin Hilman wrote:
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

I guess this is because arm-soc's doesn't have linux-next's
93746e70be83a3f113134a16065957b324af50f7

Which also explains why linux-next still boots.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/260f3bd9/attachment.sig>
