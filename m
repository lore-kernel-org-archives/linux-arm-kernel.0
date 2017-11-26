From: robh@kernel.org (Rob Herring)
Date: Sun, 26 Nov 2017 13:00:56 -0600
Subject: [PATCH v2 3/6] devicetree/bindings: display: Add bindings for
 SGD GKTW70SDAE4SE Panel
In-Reply-To: <1511348560-28505-4-git-send-email-narmstrong@baylibre.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
 <1511348560-28505-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <20171126190056.zeioijp5wwl52v7f@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 22, 2017 at 12:02:37PM +0100, Neil Armstrong wrote:
> The GKTW70SDAE4SE is an LVDS display panel.
> Their bindings are modelled on the the LVDS panel bindings.

Be consistent with your subjects. "dt-bindings: "

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/display/panel/sgd,gktw70sdae4se.txt   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.txt

With that,

Acked-by: Rob Herring <robh@kernel.org>
