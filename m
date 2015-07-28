From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 28 Jul 2015 13:10:45 +0800
Subject: [PATCH v4 1/7] clk: mediatek: Add fixed clocks support for
 Mediatek SoC.
In-Reply-To: <CAGS+omAhnqy7AZ6x7QoEez3Fq8ghkj5_DrNCf18c0AO+aKnoyQ@mail.gmail.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <1437706925-3222-2-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omAhnqy7AZ6x7QoEez3Fq8ghkj5_DrNCf18c0AO+aKnoyQ@mail.gmail.com>
Message-ID: <1438060245.17770.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-07-24 at 19:33 +0800, Daniel Kurtz wrote:
> Hi James,
> 
> On Fri, Jul 24, 2015 at 11:01 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> >
> > +void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> > +               struct clk_onecell_data *clk_data)
> 
> 
> void __init mtk_clk_register_fixed_clks(...

It will be added in next patch.


> > -extern void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> > +void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> 
> Technically, this hunk is unrelated and should probably be in its own patch.

It will be in a separated patch.


Best regards,

James
