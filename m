From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 04:24:56 -0700
Subject: [PATCH 1/4] dt-bindings: clk: hisilicon: Add bindings for Hi3670
 clk
In-Reply-To: <20180921060103.21370-2-manivannan.sadhasivam@linaro.org>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20180921060103.21370-2-manivannan.sadhasivam@linaro.org>
Message-ID: <5baa1b09.1c69fb81.623e5.51ea@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Sep 2018 23:01:00 -0700, Manivannan Sadhasivam wrote:
> Add devicetree bindings for HiSilicon Hi3670 clock controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/clock/hi3670-clock.txt           |  43 +++
>  include/dt-bindings/clock/hi3670-clock.h      | 348 ++++++++++++++++++
>  2 files changed, 391 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3670-clock.txt
>  create mode 100644 include/dt-bindings/clock/hi3670-clock.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
