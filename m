From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Jun 2017 16:28:24 -0500
Subject: [PATCH v4 5/6] dt-bindings: display: stm32: Add DSI host driver
In-Reply-To: <1497889685-27349-6-git-send-email-philippe.cornu@st.com>
References: <1497889685-27349-1-git-send-email-philippe.cornu@st.com>
 <1497889685-27349-6-git-send-email-philippe.cornu@st.com>
Message-ID: <20170623212824.3c5ny3jn7xfxw2ab@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 06:28:04PM +0200, Philippe CORNU wrote:
> This patch adds documentation of device tree bindings for the STM32
> DSI host driver based on the Synopsys DW MIPI DSI bridge driver.

Same comment here. With that,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Philippe CORNU <philippe.cornu@st.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 104 ++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 1 deletion(-)
