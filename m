From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jul 2016 07:46:56 -0500
Subject: [PATCH 1/3] dt-bindings: add power domains to Tegra BPMP firmware
In-Reply-To: <20160719191442.15439-1-swarren@wwwdotorg.org>
References: <20160719191442.15439-1-swarren@wwwdotorg.org>
Message-ID: <20160720124656.GA18773@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:14:40PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra186 BPMP is also a provider of power domains. Enhance the device
> tree binding to describe this.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> These patches all build on top of Joseph Lo's baseline BPMP binding patches[1]
> and enhance them to represent a few more features of the firmware.
> 
> [1] https://lkml.org/lkml/2016/7/19/280
> "[PATCH V3 01/10] Documentation: dt-bindings: mailbox: tegra: Add binding for HSP mailbox"
> 
>  .../bindings/firmware/nvidia,tegra186-bpmp.txt     | 10 ++++--
>  include/dt-bindings/power/tegra186-powergate.h     | 39 ++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/power/tegra186-powergate.h

Acked-by: Rob Herring <robh@kernel.org>
