From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 23:35:31 -0600
Subject: [PATCH 1/4] clk: stm32f7: Add stm32f7 clock DT bindings for
 STM32F746 boards
In-Reply-To: <1483711165-17149-2-git-send-email-gabriel.fernandez@st.com>
References: <1483711165-17149-1-git-send-email-gabriel.fernandez@st.com>
 <1483711165-17149-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170110053531.dp2xt3bpprzb76gi@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 02:59:22PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces the stm32f7 clock DT bindings.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32-rcc.txt       | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/stm32fx-clock.h            | 20 ++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
