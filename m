From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 13:46:33 -0600
Subject: [PATCH v2 12/16] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
In-Reply-To: <538e93d723d7755928ad118564a571371cb337b6.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <538e93d723d7755928ad118564a571371cb337b6.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20180111194633.5gbvtok2w6q3ievu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 10:33:43AM +0100, Quentin Schulz wrote:
> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

You didn't add my R-by nor address Jonathan's comments on v1.

Rob
