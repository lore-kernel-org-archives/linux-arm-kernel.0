From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:16 -0600
Subject: [PATCH 1/3] dt-bindings: pwm-stm32-lp: add #pwm-cells
In-Reply-To: <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
 <1517492678-767-2-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180205060916.4djyij3ximpwsfag@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 02:44:36PM +0100, Fabrice Gasnier wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> STM32 Low-Power Timer supports generic 3 cells pwm to encode
> PWM number, period and polarity.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
