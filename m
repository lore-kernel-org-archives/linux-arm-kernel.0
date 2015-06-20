From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 20 Jun 2015 11:43:48 -0300
Subject: [PATCH v2 2/6] imx35: define two clocks for rtc
In-Reply-To: <1434809732-8996-3-git-send-email-tremyfr@gmail.com>
References: <1434809732-8996-1-git-send-email-tremyfr@gmail.com>
 <1434809732-8996-3-git-send-email-tremyfr@gmail.com>
Message-ID: <CAOMZO5DOC2WXAVLxv_srHAZVAtnhTaP1yqYL9iQvJivKHRj1jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 11:15 AM, Philippe Reynes <tremyfr@gmail.com> wrote:

> @@ -240,6 +241,9 @@ int __init mx35_clocks_init(void)
>         clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.1");
>         clk_register_clkdev(clk[uart3_gate], "per", "imx21-uart.2");
>         clk_register_clkdev(clk[ipg], "ipg", "imx21-uart.2");
> +       /* i.mx35 has the i.mx21 type uart */

I think you meant rtc, not uart :-)
