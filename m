From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:07:20 -0600
Subject: [PATCH v2 3/8] dt-bindings: mfd: stm32-timers: add support for
 dmas
In-Reply-To: <1516979499-3665-4-git-send-email-fabrice.gasnier@st.com>
References: <1516979499-3665-1-git-send-email-fabrice.gasnier@st.com>
 <1516979499-3665-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20180205060720.v3sfw44orngsyltq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 04:11:34PM +0100, Fabrice Gasnier wrote:
> Add support for DMAs to STM32 timers. STM32 Timers can support up to 7
> dma requests: up to 4 channels, update, compare and trigger.
> DMAs may be used to transfer data from pwm capture for instance.
> DMA support is made optional, PWM capture support is also an option.
> This is much more wise system-wide to avoid shortage on DMA request
> lines as there's significant amount of timer instances that can
> request up to 7 channels.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
