From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:49:30 -0500
Subject: [PATCH v1 1/8] dt-bindings: stm32-dma: introduce DMA features
 bitfield
In-Reply-To: <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
References: <1520959327-25760-1-git-send-email-pierre-yves.mordret@st.com>
 <1520959327-25760-2-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180318124930.tgd4llar3zat7idx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 05:42:00PM +0100, Pierre-Yves MORDRET wrote:
> This bitfield intends to address features to be activated within the
> driver. Initially the mask was only meant for FIFO Threshold management.
> Backward compatibility is preserved but the meaning of this field has been
> extended to features instead of only threshold.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
> ---
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
