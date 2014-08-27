From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Aug 2014 22:17:19 +0200
Subject: [PATCH v2 2/2] dt-bindings: document Rockchip thermal
In-Reply-To: <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
References: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com>
 <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <5911166.ElkaNhDZrP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 August 2014 07:41:43 Caesar Wang wrote:
> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "tsadc_pclk" for
> +    the peripheral clock.
> 

Why not just name them "clk" and "pclk"? The "tsadc" part seems highly redundant.

Alternatively, how about "transfer" and "peripheral"?

	Arnd
