From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 15:31:40 -0500
Subject: [PATCH v2 1/5] dt-bindings: gk20a: Fix typo in compatible name
In-Reply-To: <1458010724-10945-2-git-send-email-acourbot@nvidia.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
 <1458010724-10945-2-git-send-email-acourbot@nvidia.com>
Message-ID: <20160318203140.GA10337@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2016 at 11:58:40AM +0900, Alexandre Courbot wrote:
> The correct compatible name is "nvidia,gk20a".
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

This may be what is used, but having the SoC name would be preferred 
assuming gk20a is in multiple SoCs.

Rob
