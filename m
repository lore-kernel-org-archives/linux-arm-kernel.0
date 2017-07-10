From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Jul 2017 08:20:04 -0500
Subject: [PATCH v2 1/4] dt-bindings: Document the STM32 MDMA bindings
In-Reply-To: <1499343941-6375-2-git-send-email-pierre-yves.mordret@st.com>
References: <1499343941-6375-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343941-6375-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170710132004.lwjweotvob2kqgv5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 02:25:38PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds documentation of device tree bindings for the STM32 MDMA
> controller.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>      v2:
>          * change compatible into st,stm32h7-mdma to be more SoC specific
> ---
> ---
>  .../devicetree/bindings/dma/stm32-mdma.txt         | 94 ++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt

Acked-by: Rob Herring <robh@kernel.org>
