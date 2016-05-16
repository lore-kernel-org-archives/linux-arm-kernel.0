From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 09:52:57 -0500
Subject: [PATCH v2 2/2] dt-bindings: Add Oxford Semiconductor OXNAS
 pinctrl and gpio bindings
In-Reply-To: <1462952062-5316-3-git-send-email-narmstrong@baylibre.com>
References: <1462952062-5316-1-git-send-email-narmstrong@baylibre.com>
 <1462952062-5316-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160516145257.GA31044@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 09:34:22AM +0200, Neil Armstrong wrote:
> Add pinctrl and gpio DT bindings for Oxford Semiconductor OXNAS SoC Family.
> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/gpio/gpio_oxnas.txt        | 47 ++++++++++++++++++
>  .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  | 57 ++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
