From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 28 Jul 2015 10:14:12 +0800
Subject: [PATCH v4 5/7] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <CAGS+omB6LpttP_67iJsGrgLv6=B28FHq7RGbcRw_LaOd4LzCLQ@mail.gmail.com>
References: <1437706925-3222-1-git-send-email-jamesjj.liao@mediatek.com>
 <1437706925-3222-6-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omB6LpttP_67iJsGrgLv6=B28FHq7RGbcRw_LaOd4LzCLQ@mail.gmail.com>
Message-ID: <1438049652.17770.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Fri, 2015-07-24 at 19:18 +0800, Daniel Kurtz wrote:
> On Fri, Jul 24, 2015 at 11:02 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> > +static const struct mtk_gate_regs cg_regs_4_8_0 = {
> 
> All of these regs tables can be __initconst.

It will be added in next patch.


Best regards,

James
