From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jun 2016 23:02:00 +0200
Subject: [PATCH v4 1/2] i2c: qup: add ACPI support
In-Reply-To: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
References: <1465409985-17113-1-git-send-email-austinwc@codeaurora.org>
Message-ID: <4749471.m1cxc4jj96@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 8, 2016 12:19:44 PM CEST Austin Christ wrote:
> +               ret = device_property_read_u32(qup->dev,
> +                               "src-clock-hz", &src_clk_freq);
> +               if (ret) {
> +                       dev_warn(qup->dev, "using default src-clock-hz %d",
> +                               DEFAULT_SRC_CLK);
> +                       src_clk_freq = DEFAULT_SRC_CLK;
> +               }
> 

Where is this property documented?

	Arnd
