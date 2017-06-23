From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 13:48:42 -0500
Subject: [PATCH 2/4] dt-bindings: Add bindings for
 nvidia,tegra186-bpmp-thermal
In-Reply-To: <20170616112825.31025-2-mperttunen@nvidia.com>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
 <20170616112825.31025-2-mperttunen@nvidia.com>
Message-ID: <20170623184842.ndb44vqyu5rtaa2e@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 02:28:23PM +0300, Mikko Perttunen wrote:
> In Tegra186, the BPMP (Boot and Power Management Processor) implements
> an interface that is used to read system temperatures, including CPU
> cluster and GPU temperatures. This binding describes the thermal sensor
> that is exposed by BPMP.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../thermal/nvidia,tegra186-bpmp-thermal.txt       | 32 ++++++++++++++++++++++
>  .../dt-bindings/thermal/tegra186-bpmp-thermal.h    | 14 ++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
>  create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h

Acked-by: Rob Herring <robh@kernel.org>
