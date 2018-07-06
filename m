From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Jul 2018 11:12:45 -0700
Subject: [PATCH v5 2/5] clk: at91: add I2S clock mux driver
In-Reply-To: <20180618141239.10892-3-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
 <20180618141239.10892-3-codrin.ciubotariu@microchip.com>
Message-ID: <153090076533.143105.11588903392800697432@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Codrin Ciubotariu (2018-06-18 07:12:36)
> This driver is a simple muxing driver that controls the
> I2S's clock input by using syscon/regmap to change the parent.
> The available inputs can be peripheral clock and generated clock.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-next

But I had to fix:

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#56: FILE: drivers/clk/at91/clk-i2s-mux.c:1:
+/* SPDX-License-Identifier: GPL-2.0 */

so I did. Please run checkpatch next time.
