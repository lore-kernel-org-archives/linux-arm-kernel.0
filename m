From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 17:26:56 -0500
Subject: [PATCH 17/20] dt-bindings: serial: stm32: add dma using note
In-Reply-To: <1498481318-1894-18-git-send-email-bich.hemon@st.com>
References: <1498481318-1894-1-git-send-email-bich.hemon@st.com>
 <1498481318-1894-18-git-send-email-bich.hemon@st.com>
Message-ID: <20170628222656.g5zqkxdsaju6byzb@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 12:49:16PM +0000, Bich HEMON wrote:
> From: Bich Hemon <bich.hemon@st.com>
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> ---
>  .../devicetree/bindings/serial/st,stm32-usart.txt  | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Sounds like broken DMA to me.

Acked-by: Rob Herring <robh@kernel.org>
