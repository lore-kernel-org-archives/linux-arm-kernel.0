From: robh@kernel.org (Rob Herring)
Date: Mon, 11 Sep 2017 15:24:03 -0500
Subject: [PATCH v4 1/4] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <1504785168-26572-2-git-send-email-pierre-yves.mordret@st.com>
References: <1504785168-26572-1-git-send-email-pierre-yves.mordret@st.com>
 <1504785168-26572-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170911202403.hlrir7bbdi7abw5n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 01:52:45PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for the STM32
> DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v4:
>         * Add multi-master ability for STM32 DMAMUX
>         * Get rid of st,dmamux properties
>     v3:
>         * Change compatible to st,stm32h7-dmamux to be mode Soc specific
>         * Add verbosity in dma-cells
>     v2:
>         * Move clock bindings from optional to mandatory one
>         * Drop channelID bindings as managed dynamically from now on by
>           DMAMUX driver.
> ---
> ---
>  .../devicetree/bindings/dma/stm32-dmamux.txt       | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt

Acked-by: Rob Herring <robh@kernel.org>
