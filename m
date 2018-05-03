From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Thu, 3 May 2018 16:30:12 -0700
Subject: [alsa-devel] [PATCH v7 01/24] soc: qcom dt-bindings: Add APR bus
 bindings
In-Reply-To: <20180501120820.11016-2-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-2-srinivas.kandagatla@linaro.org>
Message-ID: <80b45848-2426-1280-c388-b79cbfec8cef@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/1/2018 5:07 AM, Srinivas Kandagatla wrote:
> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> bus driver. This bus is used for communicating with DSP which provides
> audio and various other services to cpu.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/soc/qcom/qcom,apr.txt      | 84 ++++++++++++++++++++++
>   include/dt-bindings/soc/qcom,apr.h                 | 28 ++++++++
>   2 files changed, 112 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,apr.txt
>   create mode 100644 include/dt-bindings/soc/qcom,apr.h
>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
