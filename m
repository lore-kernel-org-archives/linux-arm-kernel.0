From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Apr 2018 13:48:35 -0500
Subject: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
In-Reply-To: <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
 <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
Message-ID: <20180416184835.paip4cerjemyqcwn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 10:10:33PM +0530, Manivannan Sadhasivam wrote:
> Define power domains for Actions Semi S900 SoC Smart Power System (SPS).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/power/actions,owl-sps.txt  |  2 ++
>  include/dt-bindings/power/owl-s900-powergate.h     | 23 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/power/owl-s900-powergate.h

Reviewed-by: Rob Herring <robh@kernel.org>
