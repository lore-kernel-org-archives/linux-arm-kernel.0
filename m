From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 16:44:09 -0600
Subject: [PATCH v2 1/3] dt-bindings: clock: Add Actions S900 clock bindings
In-Reply-To: <1509997552-29718-2-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509997552-29718-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509997552-29718-2-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <20171106224409.7viz5ylvdszeorxk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 07, 2017 at 01:15:50AM +0530, Manivannan Sadhasivam wrote:
> Add Actions Semi S900 clock bindings.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Changes in v2:
> 
> 1. Added binding header to this patch
> 2. Changed clock-controller node name to cmu
> 3. Added clocks property to cmu node
> 4. Changed compatible property value to "actions,s900-cmu"
> 5. Fixed example UART controller node
> 6. Fixed tab vs space issue
> 
>  .../devicetree/bindings/clock/actions,s900-cmu.txt |  47 +++++++
>  include/dt-bindings/clock/actions,s900-cmu.h       | 139 +++++++++++++++++++++
>  2 files changed, 186 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
>  create mode 100644 include/dt-bindings/clock/actions,s900-cmu.h

Acked-by: Rob Herring <robh@kernel.org>
