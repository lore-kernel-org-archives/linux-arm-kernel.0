From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 10:45:06 -0500
Subject: [PATCH v3 1/2] dt-bindings: mailbox: add STMicroelectronics
 STM32 IPCC binding
In-Reply-To: <1523269706-23724-2-git-send-email-fabien.dessenne@st.com>
References: <1523269706-23724-1-git-send-email-fabien.dessenne@st.com>
 <1523269706-23724-2-git-send-email-fabien.dessenne@st.com>
Message-ID: <20180409154506.fszkflmyhprd5ztk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 12:28:25PM +0200, Fabien Dessenne wrote:
> Add a binding for the STMicroelectronics STM32 IPCC block exposing a
> mailbox mechanism between two processors.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/mailbox/stm32-ipcc.txt     | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt

Please add acks/reviewed-bys when posting new versions.

Rob
