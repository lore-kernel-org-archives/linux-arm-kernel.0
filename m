From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 22:57:23 -0500
Subject: [PATCH v3 3/5] dt-bindings: stm32-dma: Add property to handle
 STM32 DMAMUX
In-Reply-To: <1499343623-5964-4-git-send-email-pierre-yves.mordret@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170710035723.gccjvuredui6l5y4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 02:20:21PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds an optional property needed for STM32 DMA controller
> addressed via STM32 DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v3:
>         * None
>     v2:
>         * Typo fix
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
