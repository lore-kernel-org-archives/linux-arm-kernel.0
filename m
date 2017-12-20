From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Dec 2017 12:24:53 -0600
Subject: [PATCH V2 4/9] devicetree: bindings: stm32: add support of
 STM32MP157
In-Reply-To: <1513610272-7824-5-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
 <1513610272-7824-5-git-send-email-ludovic.Barre@st.com>
Message-ID: <20171220182453.43zvzxapxmwzvpq4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 04:17:47PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds STM32MP157 SoC bindings.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32.txt | 1 +
>  1 file changed, 1 insertion(+)

"dt-bindings: ..." is the preferred subject prefix. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
