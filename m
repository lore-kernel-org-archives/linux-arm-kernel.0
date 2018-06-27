From: robh@kernel.org (Rob Herring)
Date: Wed, 27 Jun 2018 10:58:05 -0600
Subject: [PATCH 1/5] dt-bindings: tegra186-gpio: Add information for
 Tegra194
In-Reply-To: <20180620125406.11906-1-mperttunen@nvidia.com>
References: <20180620125406.11906-1-mperttunen@nvidia.com>
Message-ID: <20180627165805.GA21522@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:54:02PM +0300, Mikko Perttunen wrote:
> The Tegra194 GPIO controller is similar to the one in Tegra186.
> Add relevant information to the device tree binding documentation.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
