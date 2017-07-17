From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 13:46:19 -0500
Subject: [PATCH 7/9] dt-bindings: serial: add compatible for stm32h7
In-Reply-To: <1499958494-19354-8-git-send-email-bich.hemon@st.com>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-8-git-send-email-bich.hemon@st.com>
Message-ID: <20170717184619.ffvt4ebzyurke3h2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:08:29PM +0000, Bich HEMON wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Introduce new compatibles for "st,stm32h7-usart" and "st,stm32h7-uart".
> This new compatible allow to use optional wake-up interrupt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  .../devicetree/bindings/serial/st,stm32-usart.txt       | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
