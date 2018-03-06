From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 20:38:06 -0600
Subject: [PATCH v2 5/6] dt-bindings: mfd: Add STM32F7 SDMMC2 rcc entry
In-Reply-To: <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
References: <1519901623-23216-1-git-send-email-patrice.chotard@st.com>
 <1519901623-23216-6-git-send-email-patrice.chotard@st.com>
Message-ID: <20180306023806.rhmpp7lwftgb74un@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 11:53:42AM +0100, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> STM32F769 SoC provides 2 SDMMC instances, add missing
> RCC SDMMC2 entry for it.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>                                 
