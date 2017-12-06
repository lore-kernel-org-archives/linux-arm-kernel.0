From: robh@kernel.org (Rob Herring)
Date: Wed, 6 Dec 2017 15:16:59 -0600
Subject: [PATCH 4/8] dt-bindings: power: supply: axp20x: add AXP813
 battery DT binding
In-Reply-To: <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <bf3682e87c75532884881d7b08840c61678cbce1.1512396054.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171206211659.epe65eetp6gr4b7f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 03:12:50PM +0100, Quentin Schulz wrote:
> The AXP813 can have a battery as power supply, so let's add it to the
> list of compatibles.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
