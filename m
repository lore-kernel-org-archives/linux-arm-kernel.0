From: robh@kernel.org (Rob Herring)
Date: Thu, 21 Jul 2016 17:06:40 -0500
Subject: [PATCH v2 2/4] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <1469092768-17489-3-git-send-email-gabriel.fernandez@st.com>
References: <1469092768-17489-1-git-send-email-gabriel.fernandez@st.com>
 <1469092768-17489-3-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20160721220640.GA18660@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:19:26AM +0200, gabriel.fernandez at st.com wrote:
> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> 
> This adds documentation of device tree bindings for the
> STM32 reset controller.
> 
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  .../devicetree/bindings/clock/st,stm32-rcc.txt     | 42 ++++++++++++++++++----
>  .../devicetree/bindings/reset/st,stm32-rcc.txt     |  6 ++++
>  2 files changed, 41 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt

Acked-by: Rob Herring <robh@kernel.org>
