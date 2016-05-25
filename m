From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 14:10:26 -0500
Subject: [PATCH v2 2/4] dt-bindings: reset: Add bindings for the Meson
 SoC Reset Controller
In-Reply-To: <1464169758-26975-3-git-send-email-narmstrong@baylibre.com>
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
 <1464169758-26975-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160525191026.GA24249@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:49:16AM +0200, Neil Armstrong wrote:
> Add DT bindings for the Meson SoC Reset Controller documentation and the
> associated include file.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.txt         |  18 ++
>  .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 210 +++++++++++++++++++++
>  include/dt-bindings/reset/amlogic,meson8b-reset.h  | 175 +++++++++++++++++
>  3 files changed, 403 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson8b-reset.h

Please add acks when posting new versions.

Rob
