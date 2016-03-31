From: robh@kernel.org (Rob Herring)
Date: Thu, 31 Mar 2016 09:31:29 -0500
Subject: [PATCH v2 1/9] dt-binding: remoteproc: Introduce Qualcomm WCNSS
 loader binding
In-Reply-To: <1459222625-11440-2-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
 <1459222625-11440-2-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <20160331143129.GA25101@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 08:36:57PM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> 
> The document defines the binding for a component that loads firmware for
> and boots the Qualcomm WCNSS core.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Dropped non-variable properties (crash reason, firmware name)
> - Split wcnss and iris definitions into separate nodes
> - Dropped qcom, prefix of regulator supplies (standard binding)
> - Interrupts and stop-state is made optional to support 8064
> 
>  .../bindings/remoteproc/qcom,wcnss-pil.txt         | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt

Acked-by: Rob Herring <robh@kernel.org>
