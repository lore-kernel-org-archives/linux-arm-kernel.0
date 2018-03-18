From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Mar 2018 07:49:51 -0500
Subject: [PATCH v2 1/2] dt-bindings: reset: add STM32MP1 resets
In-Reply-To: <1521045001-30788-2-git-send-email-gabriel.fernandez@st.com>
References: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
 <1521045001-30788-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20180318124951.4ayn7iadpmube5f7@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 05:30:00PM +0100, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch adds the reset binding entry for STM32MP1
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 ++
>  include/dt-bindings/reset/stm32mp1-resets.h        | 108 +++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
>  create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

Reviewed-by: Rob Herring <robh@kernel.org>
