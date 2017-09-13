From: robh@kernel.org (Rob Herring)
Date: Wed, 13 Sep 2017 12:45:36 -0500
Subject: [PATCH v4 3/4] dt-bindings: stm32-dma: add a property to handle
 STM32 DMAMUX
In-Reply-To: <1504785168-26572-4-git-send-email-pierre-yves.mordret@st.com>
References: <1504785168-26572-1-git-send-email-pierre-yves.mordret@st.com>
 <1504785168-26572-4-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20170913174536.2hy6ubeef2s55t7y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 07, 2017 at 01:52:47PM +0200, Pierre-Yves MORDRET wrote:
> STM32 DMA controller has to exposed its number of request line to be
> addressed via STM32 DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>  Version history:
>     v4:
>         * get rid of st,dmamux property
>         * number of DMA requests is exposed for DMAMUX
>     v3:
>         * None
>     v2:
>         * Typo fix
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
