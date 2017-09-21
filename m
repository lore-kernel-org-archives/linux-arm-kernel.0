From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Sep 2017 17:48:11 -0500
Subject: [PATCH v5 1/4] dt-bindings: Document the STM32 DMAMUX bindings
In-Reply-To: <1506007761-11621-2-git-send-email-pierre-yves.mordret@st.com>
References: <1506007761-11621-1-git-send-email-pierre-yves.mordret@st.com>
 <1506007761-11621-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170921224811.65q3vnvq6ce7gqdk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 05:29:18PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds the documentation of device tree bindings for the STM32
> DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v5:
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

I acked v4. Please add acks when posting new versions.

Rob
