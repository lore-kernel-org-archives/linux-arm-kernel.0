From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 4 Sep 2012 09:12:17 +0800
Subject: [PATCH v3 0/4] Add device tree support for on-chip SRAM
In-Reply-To: <1346688128-22395-1-git-send-email-p.zabel@pengutronix.de>
References: <1346688128-22395-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20120904011215.GJ2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 06:02:04PM +0200, Philipp Zabel wrote:
> Changes since v2, as per Shawn's suggestions:
>  - Moved struct device_node declaration out of #ifdef CONFIG_OF.
>  - Simplified of_get_named_gen_pool using of_parse_phandle and
>    of_address_to_resource.
>  - Return -EADDRNOTAVAIL if devm_request_and_ioremap fails.
>  - Squashed i.MX changes together.
> 
For the series:

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

Though it will be very simple one, we may still need a binding doc for
that "sram" driver.

Regards,
Shawn
