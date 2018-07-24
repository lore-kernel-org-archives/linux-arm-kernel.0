From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 22:03:12 +0200
Subject: [PATCH] dt-bindings: thermal: samsung: Add SPDX license identifier
In-Reply-To: <2442216.oppRSGRAaL@amdc3058>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
 <20180718200250.6478-1-krzk@kernel.org>
 <2442216.oppRSGRAaL@amdc3058>
Message-ID: <20180724200312.xs6u4nvhjckukkig@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> > 
> > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> > index 0646500bca69..642e4e7f4084 100644
> > --- a/include/dt-bindings/thermal/thermal_exynos.h
> > +++ b/include/dt-bindings/thermal/thermal_exynos.h
> > @@ -1,19 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> 
> This code should be GPL-2.0 only, original license statement is most
> likely result of using wrong file as the source of copy-paste. So I
> would like to have the license fixed first before doing conversion to
> SPDX.

If you think that's the case, then it makes sense and please go ahead.
As fair as I remember this required signed-off from all contributors...
so probably just Lukasz and Eduardo?

Best regards,
Krzysztof
