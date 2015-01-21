From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 21 Jan 2015 15:49:45 +0800
Subject: [PATCH v3 2/4] clk: mediatek: Add initial common clock support
 for Mediatek SoCs.
In-Reply-To: <CABuKBeLFvP4ChnzzUJwoLtCHtH6PejENJueBd7D+xMJhBMDBkg@mail.gmail.com>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-3-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeLQkTBYWkBWAYXjYudMAza+1zueRSqGFPd+480p1rYNwg@mail.gmail.com>
 <1420685701.27952.44.camel@mtksdaap41>
 <CABuKBeLFvP4ChnzzUJwoLtCHtH6PejENJueBd7D+xMJhBMDBkg@mail.gmail.com>
Message-ID: <1421826585.2437.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, 2015-01-20 at 13:39 +0100, Matthias Brugger wrote:
> I think you should use spin_lock_irqsave(&clk_ops_lock, flags) instead
> of mtk_clk_lock.
> In any case I think you should define a spinlock in clk-mt8135.c and
> pass a reference of it in the init functions.
> See drivers/clk/berlin as a good example.

I see. I'll change it in next patch.


Best regards,
James
