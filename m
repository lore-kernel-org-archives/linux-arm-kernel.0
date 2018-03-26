From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:23:00 -0500
Subject: [PATCH 1/2] dt-bindings: Document qcom,adreno-gmu
In-Reply-To: <20180316185152.32020-2-jcrouse@codeaurora.org>
References: <20180316185152.32020-1-jcrouse@codeaurora.org>
 <20180316185152.32020-2-jcrouse@codeaurora.org>
Message-ID: <20180326222300.tls7bsnr4pz7ri2t@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 12:51:51PM -0600, Jordan Crouse wrote:
> Document the device tree bindings for the Adreno GMU device
> available on Adreno a6xx targets.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  .../devicetree/bindings/display/msm/gmu.txt        | 54 ++++++++++++++++++++++
>  .../devicetree/bindings/display/msm/gpu.txt        | 10 +++-
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

Reviewed-by: Rob Herring <robh@kernel.org>
