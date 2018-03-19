From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Mon, 19 Mar 2018 11:59:36 +0800
Subject: [PATCH v5 3/4] clk: lpc32xx: Set name of regmap_config
In-Reply-To: <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com>
 <20180312095142.30854-4-jeffy.chen@rock-chips.com>
 <23a9cbf8-9b1d-f7ec-b980-a16c9b2c4d84@mleia.com>
Message-ID: <5AAF35A8.3040107@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 03/19/2018 05:57 AM, Vladimir Zapolskiy wrote:
>> >  static struct regmap_config lpc32xx_scb_regmap_config = {
>> >+	.name = "lpc32xx-scb",
> please rename it to "scb", LPC32xx SoC name is already known from the context.
>
> When it's done, feel free to add to the next version my
>
> Acked-by: Vladimir Zapolskiy<vz@mleia.com>
>

ok, will do, thanks:)
