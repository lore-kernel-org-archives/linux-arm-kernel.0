From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:48:44 -0500
Subject: [PATCH v2 1/2] dt-bindings: mailbox: add STMicroelectronics
 STM32 IPCC binding
In-Reply-To: <1520852307-26659-2-git-send-email-fabien.dessenne@st.com>
References: <1520852307-26659-1-git-send-email-fabien.dessenne@st.com>
 <1520852307-26659-2-git-send-email-fabien.dessenne@st.com>
Message-ID: <20180318124844.qp4ks2nhijq5gwdb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 11:58:26AM +0100, Fabien Dessenne wrote:
> Add a binding for the STMicroelectronics STM32 IPCC block exposing a
> mailbox mechanism between two processors.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/mailbox/stm32-ipcc.txt     | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
