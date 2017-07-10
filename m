From: robh@kernel.org (Rob Herring)
Date: Sun, 9 Jul 2017 22:51:37 -0500
Subject: [PATCH 2/2] dt-bindings: media: Add Amlogic Meson AO-CEC bindings
In-Reply-To: <1499336870-24118-3-git-send-email-narmstrong@baylibre.com>
References: <1499336870-24118-1-git-send-email-narmstrong@baylibre.com>
 <1499336870-24118-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20170710035137.nd76qgjes5pwbk7d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 06, 2017 at 12:27:50PM +0200, Neil Armstrong wrote:
> The Amlogic SoCs embeds a standalone CEC Controller, this patch adds this
> device bindings.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/media/meson-ao-cec.txt     | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/meson-ao-cec.txt

Acked-by: Rob Herring <robh@kernel.org>
