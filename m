From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Dec 2013 08:40:20 +0000 (UTC)
Subject: [PATCHv10 04/41] CLK: TI: Add DPLL clock support
In-Reply-To: <1385453182-24421-5-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-5-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312170838530.14039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
> new file mode 100644
> index 0000000..921a409
> --- /dev/null
> +++ b/drivers/clk/ti/dpll.c
> @@ -0,0 +1,597 @@

...

> +/**
> + * of_ti_dpll_setup - Setup function for OMAP DPLL clocks
> + *
> + * @node: device node containing the DPLL info
> + * @ops: ops for the DPLL
> + * @ddt: DPLL data template to use
> + * @init_flags: flags for controlling init types
> + */

The kerneldoc-nano for this function isn't right.  The blank line
before the arguments should be removed.


- Paul
