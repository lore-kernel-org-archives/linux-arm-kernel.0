From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Aug 2018 12:49:54 -0600
Subject: [PATCH 3/9] dt-bindings: reset: Add binding constants for
 Actions Semi S700 RMU
In-Reply-To: <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <20180727184527.13287-4-manivannan.sadhasivam@linaro.org>
Message-ID: <20180807184954.GA7945@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2018 at 12:15:21AM +0530, Manivannan Sadhasivam wrote:
> Add device tree binding constants for Actions Semi S700 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../dt-bindings/reset/actions,s700-reset.h    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s700-reset.h

This can go in the previous patch. Either way

Reviewed-by: Rob Herring <robh@kernel.org>
