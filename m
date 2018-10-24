From: robh@kernel.org (Rob Herring)
Date: Wed, 24 Oct 2018 08:55:24 -0500
Subject: [PATCH v5 02/11] dt-bindings: power: supply: axp20x: add AXP803
 power bindings
In-Reply-To: <20181023185330.10472-3-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-3-oskari@lemmela.net>
Message-ID: <20181024135524.GA30329@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 09:53:21PM +0300, Oskari Lemmela wrote:
> The AXP803 power supplies are compatible with AXP813, but
> add specific compatibles for them.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt         | 1 +
>  .../devicetree/bindings/power/supply/axp20x_battery.txt          | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
