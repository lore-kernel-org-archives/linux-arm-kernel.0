From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Oct 2016 10:05:25 -0500
Subject: [PATCH V5 01/10] Documentation: DT: qcom_hidma: update binding
 for MSI
In-Reply-To: <1475817915-11976-2-git-send-email-okaya@codeaurora.org>
References: <1475817915-11976-1-git-send-email-okaya@codeaurora.org>
 <1475817915-11976-2-git-send-email-okaya@codeaurora.org>
Message-ID: <20161010150525.GA27057@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2016 at 01:25:06AM -0400, Sinan Kaya wrote:
> Adding a new binding for qcom,hidma-1.1 to distinguish HW supporting
> MSI interrupts from the older revision.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
