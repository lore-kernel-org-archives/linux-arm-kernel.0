From: tony@atomide.com (Tony Lindgren)
Date: Thu, 20 Oct 2016 05:59:41 -0700
Subject: [PATCHv4 09/15] clk: ti: move omap2_init_clk_clkdm under TI
 clock driver
In-Reply-To: <1476805568-19264-10-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-10-git-send-email-t-kristo@ti.com>
Message-ID: <20161020125941.msiqaruuefbomquo@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [161018 08:47]:
> This is not needed outside the driver, so move it inside it and remove
> the prototype from the public header also.

Looks safe to merge along with the other clock patches:

Acked-by: Tony Lindgren <tony@atomide.com>
