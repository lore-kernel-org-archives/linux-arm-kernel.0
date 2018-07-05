From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Jul 2018 15:13:31 -0600
Subject: [PATCH v7 09/10] dt-bindings: counter: Adjust dt-bindings for
 STM32 lptimer move
In-Reply-To: <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
Message-ID: <20180705211331.GA2404@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 05:08:57PM -0400, William Breathitt Gray wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> The STM32 LP Timer counter driver now resides under the Counter
> subsystem. This patch adjusts dt-bindings to account for the STM32
> lptimer driver move.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
>  Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

Acked-by: Rob Herring <robh@kernel.org> 
