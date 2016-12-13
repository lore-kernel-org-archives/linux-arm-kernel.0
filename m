From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Dec 2016 14:09:06 -0600
Subject: [PATCH 3/9] dt-bindings: stm32-dma: Fix typo regarding DMA
 client binding
In-Reply-To: <1481636451-27863-4-git-send-email-cedric.madianga@gmail.com>
References: <1481636451-27863-1-git-send-email-cedric.madianga@gmail.com>
 <1481636451-27863-4-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20161213200906.zikhjnvivqrdpgqh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 02:40:45PM +0100, M'boumba Cedric Madianga wrote:
> Only four cells are required for dma client binding not five.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Reviewed-by: Ludovic BARRE <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
