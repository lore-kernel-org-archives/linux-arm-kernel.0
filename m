From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 22:56:25 -0500
Subject: [PATCH v3 1/5] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <1499343623-5964-2-git-send-email-pierre-yves.mordret@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170710035625.ylgiubqfd3lnuslo@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 02:20:19PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for the STM32
> DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v3:
>         * change compatible to st,stm32h7-dmamux to be mode Soc specific
>         * add verbosity in dma-cells
>     v2:
>         * Move clock bindings from optional to mandatory one
>         * Drop channelID bindings as managed dynamically from now on by
>           DMAMUX driver.
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dmamux.txt       | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt

Acked-by: Rob Herring <robh@kernel.org>
