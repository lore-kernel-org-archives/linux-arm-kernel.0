From: robh@kernel.org (Rob Herring)
Date: Tue, 1 May 2018 07:37:18 -0500
Subject: [PATCH v7 04/24] ASoC: qdsp6: dt-bindings: Add q6afe dt bindings
In-Reply-To: <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-5-srinivas.kandagatla@linaro.org>
Message-ID: <20180501123718.GA25915@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 01:08:00PM +0100, Srinivas Kandagatla wrote:
> This patch add DT bindings for AFE (Audio Frontend) DSP module.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.txt       | 104 +++++++++++++++++++++
>  include/dt-bindings/sound/qcom,q6afe.h             |  31 ++++++
>  2 files changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.txt
>  create mode 100644 include/dt-bindings/sound/qcom,q6afe.h

Reviewed-by: Rob Herring <robh@kernel.org>
