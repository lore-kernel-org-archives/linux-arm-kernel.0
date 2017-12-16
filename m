From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 12:01:53 -0600
Subject: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
In-Reply-To: <20171215042528.28715-4-d-gerlach@ti.com>
References: <20171215042528.28715-1-d-gerlach@ti.com>
 <20171215042528.28715-4-d-gerlach@ti.com>
Message-ID: <20171216180136.sn4fmf26vcbb56u6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 10:25:27PM -0600, Dave Gerlach wrote:
> Document the devicetree bindings that describe Texas Instruments
> opp-supply which allow a platform to describe multiple regulators and
> additional information, such as registers containing data needed to
> program aforementioned regulators.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../bindings/opp/ti-omap5-opp-supply.txt           | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

Acked-by: Rob Herring <robh@kernel.org>
