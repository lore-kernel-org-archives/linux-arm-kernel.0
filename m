From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 4 Oct 2016 15:46:40 +0200
Subject: [PATCH v2 5/7] arm64: dts: exynos: Add dts files for Samsung
 Exynos5433 64bit SoC
In-Reply-To: <CAMuHMdV3WdS75QXsJgEXirqV-d=RJa-LTq4OdvS6fgQWS+DO-A@mail.gmail.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-6-git-send-email-cw00.choi@samsung.com>
 <CAMuHMdV3WdS75QXsJgEXirqV-d=RJa-LTq4OdvS6fgQWS+DO-A@mail.gmail.com>
Message-ID: <20161004134640.GA4150@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 03:37:35PM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 24, 2016 at 3:49 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> 
> > +       cluster_a53_opp_table: opp_table0 {
> > +               compatible = "operating-points-v2";
> > +               opp-shared;
> > +
> > +               opp at 400000000 {
> > +                       opp-hz = /bits/ 64 <400000000>;
> > +                       opp-microvolt = <900000>;
> > +               };
> 
> With W=1:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp at 400000000 has a
> unit name, but no reg property

AFAIR, there should be an exception for this... [1] But maybe it was not
added after all?

Best regards,
Krzysztof


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/419738.html
