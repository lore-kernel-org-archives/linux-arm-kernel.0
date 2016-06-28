From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2016 23:47:49 -0700
Subject: [RESEND PATCHv2 01/28] clk: ti: add ti_clk_get helper API
In-Reply-To: <1465844702-12200-2-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
 <1465844702-12200-2-git-send-email-t-kristo@ti.com>
Message-ID: <20160628064749.GB28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160613 12:07]:
> The API can be used to fetch directly DT clocks based on name. Using
> this new API allows getting rid of most of the DT_CLK() entries under
> drivers/clk/ti.

The description here is a bit confusing.. Rather than calling it API
how about say it's a helper function private to TI specific clock
code? Otherwise people might think it will be something more widely
available.

Regards,

Tony
