From: jamesjj.liao@mediatek.com (james liao)
Date: Mon, 1 Dec 2014 11:41:10 +0800
Subject: [PATCH 2/4] clk: Add INFRA and PERI clocks for Mediatek MT8135.
In-Reply-To: <20141128120636.GD25883@leverpostej>
References: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
 <1417174490-6845-3-git-send-email-jamesjj.liao@mediatek.com>
 <20141128120636.GD25883@leverpostej>
Message-ID: <1417405278.31427.15.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 2014-11-28 at 12:06 +0000, Mark Rutland wrote:
> On Fri, Nov 28, 2014 at 11:34:48AM +0000, James Liao wrote:
> > This patch adds clock gates support for Mediatek SoCs, and adds clocks of
> > INFRA sys and PERI sys for MT8135.
> > 
> 
> Please fold the include/dt-bindings changes into the DT documentation
> patch, and put that earlier in the series.
> 

OK, I'll send a new patchset later with the following sequence:

1. include/dt-bindings + DT documention.
2. Basic clocks (PLLs + TOPCKGEN).
3. Basic clocks (INFRA + PERI)
4. Update device tree to enable clocks.


Best regards,

James
