From: robh@kernel.org (Rob Herring)
Date: Fri, 12 Oct 2018 10:44:54 -0500
Subject: [PATCH v3 1/7] dt-bindings: power: supply: axp20x: add AXP813 AC
 power DT binding
In-Reply-To: <20181008181908.9456-2-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
 <20181008181908.9456-2-oskari@lemmela.net>
Message-ID: <20181012154454.GA15048@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  8 Oct 2018 21:19:02 +0300, Oskari Lemmela wrote:
> The AXP803/AXP813 AC power supply can limit input current and voltage.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  .../devicetree/bindings/power/supply/axp20x_ac_power.txt       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
