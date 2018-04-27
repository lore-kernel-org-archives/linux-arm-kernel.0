From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Apr 2018 09:07:38 -0500
Subject: [PATCH v6 01/24] soc: qcom dt-bindings: Add APR bus bindings
In-Reply-To: <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-2-srinivas.kandagatla@linaro.org>
Message-ID: <20180427140738.lpoi7ow7bgzjrumf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:45:43AM +0100, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
>  include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>  create mode 100644 include/dt-bindings/soc/qcom,apr.h

Reviewed-by: Rob Herring <robh@kernel.org>
